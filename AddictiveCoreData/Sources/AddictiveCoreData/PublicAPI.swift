import Foundation
import SwiftUI

// MARK: - Interface

/// Interactions available with persisted content
///
public protocol AddictiveCoreDataContentService {

    /// Adds new content (or, if existing, updates its rating)
    func persist(content: AddictiveCoreDataContent)

    /// Deletes targeted content by identifier
    func delete(content: AddictiveCoreDataContent)

    /// Finds content matching
    func fetch(query: AddictiveCoreDataSearchQuery) -> AddictiveCoreDataSearchResult

    /// Returns content whose ids match the targets
    func fetch(contentServiceIDs: [AddictiveCoreDataContent.ServiceIdentifier]) -> AddictiveCoreDataSearchResult

    /// Adds new content in a batch
    func persist(newContent: [AddictiveCoreDataContent])

}

// MARK: - Objects

/// Parameters available for searching persisted content
///
public struct AddictiveCoreDataSearchQuery {
    public var query: String
    public var offset: Int
    public var batchLimit: Int?

    public init(query: String, offset: Int, batchLimit: Int?) {
        self.query = query
        self.offset = offset
        self.batchLimit = batchLimit
    }
}

/// Persisted content found
///
public struct AddictiveCoreDataSearchResult {
    public var results: [AddictiveCoreDataContent]
    public var offset: Int
    public var totalResults: Int

    public init(results: [AddictiveCoreDataContent], offset: Int, totalResults: Int) {
        self.results = results
        self.offset = offset
        self.totalResults = totalResults
    }
}


/// In-memory model for persisted content
///
public struct AddictiveCoreDataContent: Equatable {

    public var rating: Int

    public typealias ServiceIdentifier = String
    public var hostID: String
    public let host: ServiceIdentifier
    public let title: String
    public let sourceLabel: String
    public let sourceURL: URL?
    public let created: Date?
    public let trendingDate: Date?

    public let repOriginalSize: CGSize
    public let repOriginalURL: URL
    public let repPreviewURL: URL

    public init(
        rating: Int,
        hostID: String,
        host: AddictiveCoreDataContent.ServiceIdentifier,
        title: String,
        sourceLabel: String,
        sourceURL: URL?,
        created: Date?,
        trendingDate: Date?,
        repOriginalSize: CGSize,
        repOriginalURL: URL,
        repPreviewURL: URL
    ) {
        self.rating = rating
        self.hostID = hostID
        self.host = host
        self.title = title
        self.sourceLabel = sourceLabel
        self.sourceURL = sourceURL
        self.created = created
        self.trendingDate = trendingDate
        self.repOriginalSize = repOriginalSize
        self.repOriginalURL = repOriginalURL
        self.repPreviewURL = repPreviewURL
    }
}
