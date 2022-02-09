import Foundation
import Combine

/// Shows a list of ordered search results
///
public protocol Browsing: ObservableObject {
    var results: [AddictiveContent] { get }
    var totalResults: Int { get }
    var isLoading: Bool   { get }
    var isSortingHighRatingsFirst: Bool     { get }
    var currentQuery: AddictiveSearchQuery? { get }

    var scrollTargetID: AnyPublisher<AddictiveContent.ID?, Never> { get }

    func search(newQuery: AddictiveSearchQuery)
    func nextSearchResultPage()
    func scroll(to id: AddictiveContent.ID?)
    func cellDidAppear(for id: AddictiveContent.ID)
    func cellDidDisappear(for id: AddictiveContent.ID)
    func toggleSortOrder()

    @discardableResult
    func setContentSource(to: ContentService, restoring: BrowsingState?) -> BrowsingState
}

public protocol ScrollObserving: ObservableObject {
    var currentLowIndex: Int  { get }
    var currentHighIndex: Int { get }
    var maxIndexReached: Int  { get }
}

/// Rate content and see other people's ratings while in SharePlay
///
public protocol ContentRating: ObservableObject {
    var content: AddictiveContent?    { get }
    var otherRatings: [(String, Int)] { get }

    func setup(for content: AddictiveContent)
    func stopRatingContent()
    func set(rating: Int)
}

/// Populates a search box's contents. Translates any options into a query request.
///
public protocol QueryComposing: ObservableObject {
    /// On-screen query text, set by ``QueryComposing/updateQuery(text:)``
    var query: String { get }
    /// Reference writable restriction on the language of results
    var language: ISO6391LanguageCode? { get set }
    /// Available languages
    var languages: [ISO6391LanguageCode] { get }

    func updateQuery(text: String)
    func submitQuery()
    func resetQuery()
}

/// Delegate to conduct a new query request
///
protocol QueryDelegate: AnyObject {
    func userSubmittedNewQuery(_ query: AddictiveSearchQuery)
}

/// Orchestrates data flow for a window
///
public protocol SessionCoordination {
    /// Use cases focused on specific interactions in the screen
    associatedtype Query: QueryComposing
    associatedtype Browser: Browsing
    associatedtype Rater: ContentRating

    var browser: Browser { get }
    var query:   Query   { get }
    var rater:   Rater   { get }
    var contentSource: ContentServiceChoices { get }

    var isResettingContentSource: Bool { get }

    var canCreateGroupSession:    Bool { get }
    var sharePlaySessionIsActive: Bool { get }
    var error: Error? { get }

    func onAppear()
    func userDismissedFocusedContent()
    func userSetFocus(to content: AddictiveContent?)
    func userSetContentSource(to source: ContentServiceChoices)

    func userToggledSharePlay()
}
