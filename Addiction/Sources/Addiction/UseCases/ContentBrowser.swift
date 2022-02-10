import Foundation
import Combine
import SwiftUI

public class ContentBrowserUseCase {

    // Grid state
    @Published public private(set) var results = [AddictiveContent]()
    @Published public private(set) var isLoading = false
    @Published public private(set) var totalResults = 0
    @Published public private(set) var isSortingHighRatingsFirst = true

    // Scroll state for unlimited scrolling (and later synchronizing SharePlay screens and Nuke prefetching)
    private static let prefetchOffset = -30
    private(set) var nextFetchIndex = ContentBrowserUseCase.prefetchOffset
    private(set) var indexes: [AddictiveContent.ID:Int] = [:]
    private(set) var mostRecentlyAppearedIndex = 0
    private(set) var mostRecentlyDisappearedIndex = 0

    /// Push a scroll-to event to the target ID in the results array
    public private(set) var scrollTargetID: AnyPublisher<AddictiveContent.ID?, Never>
    public private(set) var scrollTargetSubject = CurrentValueSubject<AddictiveContent.ID?,Never>(nil)

    // Services
    private(set) weak var activeContentService: ContentService?
    private(set) weak var ratingReferenceService: LocalContentService?
    public private(set) var currentQuery: AddictiveSearchQuery? = nil
    private var currentRequest: AnyCancellable? = nil
    private let queue = DispatchQueue(label: Bundle.main.bundleIdentifier!+".contentBrowser", attributes: .concurrent)

    internal init(content: ContentService, localService: LocalContentService) {
        self.activeContentService = content
        self.ratingReferenceService = localService
        self.scrollTargetID = scrollTargetSubject.eraseToAnyPublisher()
    }

    enum Direction { case up, down }
}

// MARK: - Public Intents

extension ContentBrowserUseCase: Browsing {

    public func onAppear() {
        loadFirstBatchOfLocalFavoriteIfAppropriate()
    }

    /// Intent from user or SharePlay to start a new search query (not for an additional batch of the current one)
    ///
    public func search(newQuery: AddictiveSearchQuery) {
        self.indexes = [:]
        self.results = []
        self.mostRecentlyAppearedIndex = 0
        self.mostRecentlyDisappearedIndex = 0
        self.nextFetchIndex = ContentBrowserUseCase.prefetchOffset
        var query = newQuery
        query.startIndex = 0

        self.fetch(query: query)
    }

    /// Intent to fetch more results from the current search query
    ///
    public func nextSearchResultPage() {
        guard var query = self.currentQuery else { return }
        if !isLoading, totalResults > results.endIndex {
            query.startIndex = results.endIndex
            fetch(query: query)
        }
    }

    /// Ascending vs descending order
    ///
    public func toggleSortOrder() {
        isSortingHighRatingsFirst.toggle()
        if isSortingHighRatingsFirst {
            results.sort { $0.rating > $1.rating  }
        } else {
            results.sort { $0.rating < $1.rating  }
        }
    }

    /// Force the display to scroll (e.g., scroll to top or SharePlay)
    ///
    public func scroll(to id: AddictiveContent.ID?) {
        scrollTargetSubject.send(id)
    }

    /// Track visible cells for prefetching
    ///
    public func cellDidAppear(for id: AddictiveContent.ID) {
        guard let index = indexes[id] else { return }
        self.mostRecentlyAppearedIndex = index
        if !isLoading, index >= nextFetchIndex {
            nextSearchResultPage()
        }
    }

    /// Track visible cells for prefetching
    ///
    public func cellDidDisappear(for id: AddictiveContent.ID) {
        guard let index = indexes[id] else { return }
        self.mostRecentlyDisappearedIndex = index
    }

    /// Switch actively searched content source (e.g., local favorites vs. remote service like Giphy)
    ///
    @discardableResult
    public func setContentSource(to service: ContentService, restoring state: BrowsingState?) -> BrowsingState {
        let cache = BrowsingState(self)
        switchContentSource(to: service, priorState: state)
        return cache
    }
}

// MARK: - Internal

private extension ContentBrowserUseCase {

    /// 1. Dispatch the query to background thread
    ///
    func fetch(query: AddictiveSearchQuery) {
        isLoading = true
        queue.async { [weak self] in
            // 1. Unwrap services
            guard let self = self,
                  let search = self.activeContentService,
                  let localRatings = self.ratingReferenceService
            else { return }
            self.buildRelevantSearchPipeline(for: query, localRatings, search)
        }
    }

    /// 2. If currently using the local ratings service for searches, don't merge ratings.
    /// Otherwise, merge ratings into search results by also placing a local content fetch request.
    ///
    func buildRelevantSearchPipeline(
        for query: AddictiveSearchQuery,
        _ localRatings: LocalContentService,
        _ content: ContentService
    ) {

        let searchOnly = content
            .search(query)
            .eraseToAnyPublisher()

        // Local only route
        if content === localRatings {
            subscribeTo(search: searchOnly, for: query)
            return
        }

        // Merge remote results with local ratings
        let pipeline = searchOnly
            .map { ($0, $0.results.map(\.hostID)) }
            .flatMap { result, ids -> AnyPublisher<([AddictiveContent], AddictiveSearchResult), Error> in
                localRatings.getContent(ids: ids)
                    .map { ratings in (ratings, result) }
                    .eraseToAnyPublisher()
            }
            .mergeLocalRatingsIntoSearchResultsInAscendingRatingOrder()
            .eraseToAnyPublisher()

        subscribeTo(search: pipeline, for: query)
    }

    /// 3. Execute the composed pipeline
    ///
    func subscribeTo(search pipeline: AnyPublisher<AddictiveSearchResult,Error>, for query: AddictiveSearchQuery) {
        self.currentRequest = pipeline
            .receiveOnMain()
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] searchResult in
                self?.displaySearchResult(searchResult, for: query)
            }
    }

    /// 4. Updates list array, labels, and indexes for reasoning about the list.
    ///
    func displaySearchResult(_ newResult: AddictiveSearchResult, for query: AddictiveSearchQuery) {
        if newResult.startIndex == 0 {
            // A new query will already arrive pre-sorted by `mergeLocalRatingsIntoSearchResultsInAscendingRatingOrder`
            results = isSortingHighRatingsFirst ? newResult.results : newResult.results.reversed()
            totalResults = newResult.resultsCount

        } else if currentQuery?.startIndex != query.startIndex {
            // Don't sort the whole list as the user is scrolling.
            // New rated items could fly to the top, unseen.
            results.append(contentsOf: newResult.results)
        }

        indexes = results.hashMapIndexesBy(\.id)
        nextFetchIndex += newResult.results.endIndex
        currentQuery = query
    }

    func switchContentSource(to service: ContentService, priorState: BrowsingState?) {
        guard service.identifier != self.activeContentService?.identifier else { return }

        self.isLoading = true
        self.currentRequest = nil
        self.currentQuery = priorState?.currentQuery
        self.totalResults = priorState?.totalResults ?? 0
        self.results = priorState?.results ?? []
        self.nextFetchIndex = priorState?.nextFetchIndex ?? Self.prefetchOffset
        self.mostRecentlyAppearedIndex = priorState?.mostRecentlyAppearedIndex ?? 0
        self.mostRecentlyDisappearedIndex = priorState?.mostRecentlyDisappearedIndex ?? 0
        self.activeContentService = service
        if let index = priorState?.mostRecentlyAppearedIndex, self.results.indices.contains(index) {
            self.scroll(to: self.results[index].id)
        }
        self.isLoading = false
        loadFirstBatchOfLocalFavoriteIfAppropriate()
    }

    func loadFirstBatchOfLocalFavoriteIfAppropriate() {
        guard activeContentService?.identifier == .favorites,
              results.isEmpty,
              currentQuery == nil || currentQuery?.query == ""
        else { return }
        search(newQuery: .init(query: "", language: nil, startIndex: 0))
    }
}
