import Foundation
import Combine
import GroupActivities

import Foundation
import Combine
import GroupActivities

/// Subclass of the SoloSessionController with its troop of generics. In the latest SwiftUI, subclassed ObservableObjects chain their ObjectWillChange publishers. In prior releases, manual chaining is required.
///
@available(macOS 12, iOS 15, *)
public class GroupSessionController<
    Query: QueryComposing,
    Browser: Browsing,
    Rater: ContentRating
>: SessionCoordinator<Query, Browser, Rater> {

    // Draft not exposed
    @Published public var isWaitingForSharePlay = false

    // Required
    @Published public var groupSession: GroupSession<GiffingActivity>?
#if DEBUG
    @Published public var debugMessages: [String] = []
#endif
    public var messenger: GroupSessionMessenger?

    public let groupObserver: GroupStateObserver
    public var sharePlaySubs = Set<AnyCancellable>()
    public var tasks = Set<Task<Void, Never>>()

    override init(_ composer: Query,
                  _ browsing: Browser,
                  _ rater: Rater,
                  _ localService: LocalContentService,
                  _ externalService: ContentService
    ) {
        self.groupObserver = GroupStateObserver()
        super.init(composer, browsing, rater, localService, externalService)
        self.canCreateGroupSession = groupObserver.isEligibleForGroupSession
        self.sharePlaySessionIsActive = false
    }

    // MARK: - Extend Base Class Behavior

    public override func onAppear() {
        super.onAppear()
        prepareSharePlay()
    }

    public override func userSubmittedNewQuery(_ query: AddictiveSearchQuery) {
        super.userSubmittedNewQuery(query)
        shareToGroupNewUserQuery(query: query)
    }

    public override func userSetFocus(to content: AddictiveContent?) {
        super.userSetFocus(to: content)
        guard let content = content else { return }
        shareToGroupFocusedContent(content: content)
    }

    public override func userToggledSharePlay() {
        if sharePlaySessionIsActive {
            endGroupSessionAndResetSharePlay()
        } else {
            startGroupSession()
        }
    }

}

// MARK: - SharePlay Implementation

@available(macOS 12, iOS 15, *)
extension GroupSessionController {

    func startGroupSession() {
        Task { [weak self] in
            do {
                _ = try await GiffingActivity().activate()
            } catch {
                self?.error = error
            }
        }
    }

    func prepareSharePlay() {
        trackSharePlayEligibility()
        listenForGroupSessionsToJoin()
    }

    /// If the system cannot create a group session (e.g., FaceTime is active), the `isEligibleForGroupSession` property will be false.
    /// This function merges that state with the presence of an ongoing session, generating a "Can I show a button to start new session?" state.
    ///
    func trackSharePlayEligibility() {
        groupObserver
            .$isEligibleForGroupSession
            .receiveOnMain()
            .sink(receiveValue: { [weak self] isEligible in
                NSLog("-> SharePlay isEligible \(isEligible)")
                let isInGroupSession = self?.groupSession != nil
                self?.canCreateGroupSession = !isInGroupSession && isEligible
            })
            .store(in: &sharePlaySubs)
    }

    /// Listen to an asynchronously updated list of available group sessions, starting any newly provided sessions.
    ///
    func listenForGroupSessionsToJoin() {
        Task {
            for await session in GiffingActivity.sessions() {
                self.configure(groupSession: session)
            }
        }
    }

    /// Sequences the tasks needed to start a SharePlay session.
    ///
    public func configure(groupSession: GroupSession<GiffingActivity>) {
        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger
        DispatchQueue.main.sync {
            self.groupSession = groupSession
        }

        _setupTrackSessionStatus(updates: groupSession.$state)
        _setupBroadcastSessionState(whenNewParticipantsJoin: groupSession.$activeParticipants)
        _setupReactToActivityMessages(from: messenger)
        groupSession.join()
    }

    func _setupTrackSessionStatus(updates state: Published<GroupSession<GiffingActivity>.State>.Publisher) {
        state
            .receiveOnMain()
            .sink { [weak self] state in
                switch state {
                case .invalidated(reason: let error):
                    self?.error = error
                    self?.groupSession = nil
                    self?.sharePlaySessionIsActive = false
                    self?.endGroupSessionAndResetSharePlay()
                case .joined:
                    self?.sharePlaySessionIsActive = true
                case .waiting:
                    self?.isWaitingForSharePlay = true
                @unknown default:
                    NSLog("Unexpected SharePlay GroupSession State")
                }
            }
            .store(in: &sharePlaySubs)
    }

    func _setupBroadcastSessionState(whenNewParticipantsJoin participants: Published<Set<Participant>>.Publisher) {
        participants
            .compactMap { [weak self] activeParticipants in
                activeParticipants
                    .subtracting(self?.groupSession?.activeParticipants ?? [])
            }
            .sink { [weak self] newParticipants in
                Task { [weak self] in
                    let query = self?.browser.currentQuery ?? .init()
                    let focus = SharedFocusMessage(content: self?.rater.content)
                    let search = SharedSearchMessage(query)
                    try? await self?.messenger?.send(focus, to: .only(newParticipants))
                    try? await self?.messenger?.send(search, to: .only(newParticipants))
                }
            }
            .store(in: &sharePlaySubs)
    }

    func _setupReactToActivityMessages(from messenger: GroupSessionMessenger) {
        var task = Task {
            for await (message, context) in messenger.messages(of: SharedSearchMessage.self) {
                DispatchQueue.main.async { [weak self] in
                    self?.handle(sharedQuery: message, from: context.source)
                }
#if DEBUG
                let count = self.debugMessages.endIndex
                self.debugMessages.append("\(count)\(message.query) \(message.currentOffset)")
#endif
            }
        }
        tasks.insert(task)

        task = Task {
            for await (message, context) in messenger.messages(of: SharedFocusMessage.self) {
                DispatchQueue.main.async { [weak self] in
                    self?.handle(sharedFocus: message, from: context.source)
                }
#if DEBUG
                let count = self.debugMessages.endIndex
                self.debugMessages.append("\(count)")
#endif
            }
        }
        tasks.insert(task)
    }

    /// React to messages from other SharePlay participants
    ///
    func handle(sharedQuery: SharedSearchMessage, from: Participant) {
        if sharedQuery.query.isEmpty || sharedQuery.query == browser.currentQuery?.query {
            return // Let everyone scroll in peace...
        }
        // Only update search when people choose a new term
        var newQuery = AddictiveSearchQuery()
        newQuery.query = sharedQuery.query
        browser.search(newQuery: newQuery)
    }

    /// React to messages from other SharePlay participants
    ///
    func handle(sharedFocus: SharedFocusMessage, from: Participant) {
        guard let content = sharedFocus.content else { return }
        self._setFocus(to: content)
    }

    /// Send user intent to other SharePlay participants
    ///
    func shareToGroupNewUserQuery(query: AddictiveSearchQuery) {
        guard let messenger = messenger else { return }
        Task {
            try? await messenger.send(SharedSearchMessage(query))
        }
    }

    /// Send user intent to other SharePlay participants
    ///
    func shareToGroupFocusedContent(content: AddictiveContent?) {
        guard let messenger = messenger else { return }
        Task {
            try? await messenger.send(SharedFocusMessage(content: content))
        }
    }

    func endGroupSessionAndResetSharePlay() {
        guard let session = groupSession else { return }
        session.leave()
        self.groupSession = nil
        self.messenger = nil
        tasks.forEach { $0.cancel() }
        tasks = []
        sharePlaySubs = []
        prepareSharePlay()
    }
}
