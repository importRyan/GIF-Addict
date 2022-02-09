import Foundation
#if os(iOS)
import CoreGraphics.CGBase // CGSize
#endif

struct SharedContentContainer: Codable {
    var version: Int
    var data: Data

    init?(_ model: AddictiveContent?) {
        guard let model = model else { return nil }
        self.version = CurrentSharedContentDTO.version
        let dto = CurrentSharedContentDTO(model: model)
        do {
            self.data = try JSONEncoder().encode(dto)
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }

    func extract() throws -> AddictiveContent? {
        let dto = try JSONDecoder().decode(CurrentSharedContentDTO.self, from: data)
        return dto.extract()
    }
}

typealias CurrentSharedContentDTO = SharedContentDTO1
extension CurrentSharedContentDTO {

    static var version = 1

    init(model: AddictiveContent) {
        self.host = model.host
        self.hostID = model.hostID
        self.title = model.title
        self.sourceLabel = model.sourceLabel
        self.sourceURL = model.sourceURL
        self.created = model.created
        self.trendingDate = model.trendingDate
        self.rating = model.rating
        self.originalURL = model.representations.originalURL
        self.originalSize = model.representations.originalSize
        self.previewURL = model.representations.previewURL
    }

    func extract() -> AddictiveContent {
        .init(hostID: self.hostID,
              host: self.host,
              title: self.title,
              sourceLabel: self.sourceLabel,
              sourceURL: self.sourceURL,
              created: self.created,
              trendingDate: self.trendingDate,
              representations: .init(
                originalURL: self.originalURL,
                originalSize: self.originalSize,
                previewURL: self.previewURL),
              rating: self.rating)
    }
}

struct SharedContentDTO1: Codable {

    public var hostID: String
    public let host: String
    public let title: String
    public let sourceLabel: String
    public let sourceURL: URL?
    public let created: Date?
    public let trendingDate: Date?
    public var rating: Int

    public let originalURL: URL
    public let originalSize: CGSize
    public let previewURL: URL
}
