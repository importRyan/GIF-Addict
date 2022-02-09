import CoreData
import Foundation
#if os(iOS)
import CoreGraphics.CGBase // CGSize
#endif

// MARK: - Model Mapping

internal extension AddictiveCoreDataContent {

    init(mo: ContentMO) {
        self.created = mo.created
        self.host = mo.host ?? ""
        self.hostID = mo.hostID ?? ""
        self.rating = .init(mo.rating)
        self.repOriginalSize = CGSize(width: CGFloat(mo.repOriginalWidth), height: CGFloat(mo.repOriginalHeight))
        self.repOriginalURL = mo.repOriginalURL ?? .init(string: "")!
        self.repPreviewURL = mo.repPreviewURL ?? .init(string: "")!
        self.sourceLabel = mo.sourceLabel ?? ""
        self.sourceURL = mo.sourceURL
        self.title = mo.title ?? ""
        self.trendingDate = mo.trending
    }

    func convertToCoreDataMO(in context: NSManagedObjectContext) -> ContentMO {
        let newMO = ContentMO(context: context)
        newMO.created = self.created
        newMO.host = self.host
        newMO.hostID = self.hostID
        newMO.rating = .init(self.rating)
        newMO.repOriginalHeight = .init(self.repOriginalSize.height)
        newMO.repOriginalWidth = .init(self.repOriginalSize.width)
        newMO.repOriginalURL = self.repOriginalURL
        newMO.repPreviewURL = self.repPreviewURL
        newMO.sourceLabel = self.sourceLabel
        newMO.sourceURL = self.sourceURL
        newMO.title = self.title
        newMO.trending = self.trendingDate
        return newMO
    }
}

extension ContentMO {
    @discardableResult
    func updating(ratingFrom content: AddictiveCoreDataContent) -> Self {
        self.rating = .init(content.rating)
        return self
    }
}
