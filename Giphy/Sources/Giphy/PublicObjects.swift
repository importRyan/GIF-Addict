import Foundation
#if os(iOS)
import CoreGraphics.CGBase // CGSize
#endif

// MARK: - GIF Item

/// GIF resource representation with metadata and URLs for various image formats
///
public struct GiphyGIF: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let sourceDomain: String
    public let sourceURL: URL?
    public let created: Date?
    public let trendingDate: Date?
    public let representations: Representations

    public struct Representations: Equatable {
        public let originalURL: URL
        public let originalSize: CGSize
        public let previewSize: CGSize
        public let previewURL: URL
    }
}

// MARK: - Search

/// Results for a keyword(s) or user name based query
///
public struct GiphySearchResult: Equatable {
    /// Index of first `gifs` element within paginated server results
    public var startIndex: Int
    /// Total number of sever results available
    public var resultsCount: Int
    public var gifs: [GiphyGIF]

    internal init(startIndex: Int, resultsCount: Int, gifs: [GiphyGIF]) {
        self.startIndex = startIndex
        self.resultsCount = resultsCount
        self.gifs = gifs
    }

    public init() {
        self.startIndex = 0
        self.gifs = []
        self.resultsCount = 0
    }
}

public struct GiphySearchQuery: Hashable, Equatable {
    public var query: String
    public var itemOffset: Int32
    public var rating: GiphyMPAARating?
    public var languageISO639: String?
    public var maxResults: Int32 = 50
    /// Reduces sent image url options. See https://developers.giphy.com/docs/optional-settings/#renditions-on-demand
    internal let bundle = "messaging_non_clips"

    public init(query: String, startAtResultIndex: Int32, rating: GiphyMPAARating?, languageISO639: String?) {
        self.query = query
        self.itemOffset = startAtResultIndex
        self.rating = rating
        self.languageISO639 = languageISO639
    }

    public init() {
        self.query = ""
        self.itemOffset = 0
        self.rating = nil
        self.languageISO639 = nil
    }
}
