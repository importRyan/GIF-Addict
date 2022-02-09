import Foundation

/// For caching and restoration of list state when switching content delivery sources
///
public struct BrowsingState: Equatable {
    var currentQuery: AddictiveSearchQuery? = nil
    var results: [AddictiveContent]
    var totalResults: Int
    var nextFetchIndex: Int
    var mostRecentlyAppearedIndex: Int
    var mostRecentlyDisappearedIndex: Int

    internal init(_ useCase: ContentBrowserUseCase) {
        self.currentQuery = useCase.currentQuery
        self.results = useCase.results
        self.totalResults = useCase.totalResults
        self.nextFetchIndex = useCase.nextFetchIndex
        self.mostRecentlyAppearedIndex = useCase.mostRecentlyAppearedIndex
        self.mostRecentlyDisappearedIndex = useCase.mostRecentlyDisappearedIndex
    }

    internal init(currentQuery: AddictiveSearchQuery? = nil, results: [AddictiveContent] = [], totalResults: Int = 0, nextFetchIndex: Int = 0, mostRecentlyAppearedIndex: Int = 0, mostRecentlyDisappearedIndex: Int = 0) {
        self.currentQuery = currentQuery
        self.results = results
        self.totalResults = totalResults
        self.nextFetchIndex = nextFetchIndex
        self.mostRecentlyAppearedIndex = mostRecentlyAppearedIndex
        self.mostRecentlyDisappearedIndex = mostRecentlyDisappearedIndex
    }
}
