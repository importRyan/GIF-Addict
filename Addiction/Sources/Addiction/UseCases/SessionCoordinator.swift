import Foundation
import Combine

extension SessionCoordinator: QueryDelegate, SessionCoordination {}

/// Base class does not support SharePlay
///
public class SessionCoordinator<
    Query: QueryComposing,
    Browser: Browsing,
    Rater: ContentRating
>: ObservableObject {

    @Published public private(set) var contentSource = ContentServiceChoices.remote
    @Published public internal(set) var canCreateGroupSession = false
    @Published public internal(set) var sharePlaySessionIsActive = false
    @Published public private(set) var isResettingContentSource = false

    @Published public var error: Error? = nil

    public let rater: Rater
    public private(set) var query: Query
    public private(set) var browser: Browser
    private weak var localService: LocalContentService?
    private weak var remoteService: ContentService?
    private var browsingStateCache: [ContentServiceChoices:BrowsingState] = [:]

    internal init(_ composer: Query,
                  _ browsing: Browser,
                  _ rater: Rater,
                  _ localService: LocalContentService,
                  _ externalService: ContentService
    ) {
        self.query = composer
        self.browser = browsing
        self.rater = rater
        self.localService = localService
        self.remoteService = externalService
    }

    public func onAppear() {
        // Do nothing
    }

    // MARK: - QueryDelegate

    internal func userSubmittedNewQuery(_ query: AddictiveSearchQuery) {
        browser.search(newQuery: query)
    }

    // MARK: - Session Coordination

    public func userSetFocus(to content: AddictiveContent?) {
        _setFocus(to: content)
    }

    public func userDismissedFocusedContent() {
        _dismissFocusedContent()
    }

    /// Switch between local and remote content sources (i.e., favorites vs. public search), stashing and restoring state
    ///
    public func userSetContentSource(to newSource: ContentServiceChoices) {
        _setSwitchContentSourceForBrowserQuery(to: newSource)
    }

    internal func _setFocus(to content: AddictiveContent?) {
        guard let content = content else {
            rater.stopRatingContent()
            return
        }
        rater.setup(for: content)
    }

    internal func  _dismissFocusedContent() {
        rater.stopRatingContent()
    }

    internal func _setSwitchContentSourceForBrowserQuery(to newSource: ContentServiceChoices) {
        /// If new source is different, and that content source is not nil, let's go!
        guard self.contentSource != newSource,
              let targetService = (newSource == .favorites ? localService : remoteService)
        else { return }

        /// -1. Experimental. This flag forces a LazyGrid to flush its Environment state.
        ///  Memory usage and performance of the dependency NukeUI needs to be investigated.
        self.isResettingContentSource = true

        /// 0. Stash/mark current source state
        let stashedContentSource = self.contentSource
        self.contentSource = newSource

        /// 1. Look for prior browsing state
        let cachedBrowsingStateForNewSource = browsingStateCache[newSource]

        /// 2. Ask the browser to switch content sources, restoring prior state if any
        let cashedBrowsingStateForFormerSource = browser.setContentSource(
            to: targetService,
            restoring: cachedBrowsingStateForNewSource
        )

        /// 3. Switch the query to the prior state that the browser is restoring
        self.query.updateQuery(text: cachedBrowsingStateForNewSource?.currentQuery?.query ?? "")

        /// 4. Cache the browser's state for the old content source
        self.browsingStateCache[stashedContentSource] = cashedBrowsingStateForFormerSource

        /// Step -1. Reverted
        self.isResettingContentSource = false
    }

    // MARK: - SharePlay Nonconformance

    public func userToggledSharePlay() {
        fatalError("Should be using a SharePlay subclass.")
    }
}

