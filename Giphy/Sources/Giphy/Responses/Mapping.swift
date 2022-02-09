import Foundation
#if os(iOS)
import CoreGraphics.CGBase // CGSize
#endif

extension GiphySearchResult {

    /// Mapped from codable types
    init(_ response: PaginatedResponse) {
        self.startIndex = response.pagination.offset
        self.resultsCount = response.pagination.totalCount ?? 0
        self.gifs = response.data.compactMap(GiphyGIF.init)
    }
}


extension GiphyGIF {

    /// Mapped from codable type
    init?(_ decoded: GIFObject) {
        guard let representations = Representations(decoded.images) else { return nil }
        self.representations = representations
        self.id = decoded.id
        self.title = decoded.title
        self.sourceDomain = decoded.sourceTLD
        self.sourceURL = URL(string: decoded.sourcePostURL.isEmpty ? decoded.source : decoded.sourcePostURL)
        self.created = giphyDateFormatter.date(from: decoded.importDatetime)
        self.trendingDate = giphyDateFormatter.date(from: decoded.trendingDatetime)
    }
}

extension GiphyGIF.Representations {

    init?(_ decoded: ImagesObject) {
        guard let original = decoded.original.mp4,
              let preview = decoded.fixedHeight.mp4,
              let originalURL = URL(string: original),
              let previewURL = URL(string: preview),
              let originalSize = CGSize(width: decoded.original.width, height: decoded.original.height),
              let previewSize = CGSize(width: decoded.fixedHeight.width, height: decoded.fixedHeight.height)
        else { return nil }
        self.originalURL = originalURL
        self.originalSize = originalSize
        self.previewURL = previewURL
        self.previewSize = previewSize
    }
}

// "2013-08-01 12:41:48"
let giphyDateFormatter: DateFormatter = {
let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

extension CGSize {
    init?(width: String, height: String) {
        guard let width = Int(width),
              let height = Int(height)
        else { return nil }
        self.init(width: width, height: height)
    }
}
