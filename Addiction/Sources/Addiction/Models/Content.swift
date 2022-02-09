import Foundation
#if os(iOS)
import CoreGraphics.CGBase // CGSize
#endif

/// Any image or video-based content
public struct AddictiveContent: Identifiable, Equatable {

    /// Unique identifier within Addiction -- NOT JUST THE HOST ID
    public var id: String { host + hostID }
    /// Unique identifier within the third party service that originally provided this content
    public var hostID: String
    /// Third party service that originally provided this content (e.g., Giphy)
    public let host: String
    /// Human-readable title of this content, possibly blank
    public let title: String
    /// Human-readable label for the source URL of this content, possibly blank
    public let sourceLabel: String
    /// Where this content was originally found or hosted, possibly unavailable
    public let sourceURL: URL?
    /// When this content was assumed to be created, possibly nil or 1970
    public let created: Date?
    /// When this content was first marked as trending, if ever. Possibly 1970, indicating it was discovered while trending.
    public let trendingDate: Date?
    /// Links to image variants representing this content
    public let representations: RemoteRepresentations
    /// User's opinion of this content
    public var rating: Int

    public struct RemoteRepresentations: Equatable {
        public let originalURL: URL
        public let originalSize: CGSize
        public let previewURL: URL

        public init(originalURL: URL, originalSize: CGSize, previewURL: URL) {
            self.originalURL = originalURL
            self.originalSize = originalSize
            self.previewURL = previewURL
        }
    }

    /// Any image or video-based content
    ///
    /// - Parameters:
    ///   - hostID: Unique identifier within the third party service that originally provided this content
    ///   - host: Third party service that originally provided this content (e.g., Giphy)
    ///   - title: Human-readable title of this content, possibly blank
    ///   - sourceLabel: Human-readable label for the source URL of this content, possibly blank
    ///   - sourceURL: Where this content was originally found or hosted, possibly unavailable
    ///   - created: When this content was assumed to be created, possibly nil or 1970
    ///   - trendingDate: When this content was first marked as trending, if ever. Possibly 1970, indicating it was discovered while trending.
    ///   - representations: Links to image variants representing this content
    ///   - rating: User's opinion of this content
    ///
    public init(hostID: String,
                host: String,
                title: String,
                sourceLabel: String,
                sourceURL: URL?,
                created: Date?,
                trendingDate: Date?,
                representations: AddictiveContent.RemoteRepresentations,
                rating: Int
    ) {
        self.hostID = hostID
        self.host = host
        self.title = title
        self.sourceLabel = sourceLabel
        self.sourceURL = sourceURL
        self.created = created
        self.trendingDate = trendingDate
        self.representations = representations
        self.rating = rating
    }
}


public extension AddictiveContent {

    func withRating(_ rating: Int) -> Self {
        var changed = self
        changed.rating = rating
        return changed
    }
}

extension AddictiveContent: Codable {

}

extension AddictiveContent.RemoteRepresentations: Codable {
    
}
