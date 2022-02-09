import Foundation
import GroupActivities

@available(macOS 12, iOS 15, *)
public struct GiffingActivity: GroupActivity {
    public var metadata: GroupActivityMetadata

    init() {
        var metadata = GroupActivityMetadata.init()
        metadata.title = NSLocalizedString("APP_TITLE", comment: "")
        metadata.type = .generic
        metadata.preferredBroadcastOptions = .mirroredVideo
        metadata.subtitle = NSLocalizedString("APP_SLUG", comment: "")
        self.metadata = metadata
    }
}

struct SharedSearchMessage: Codable {

    let query: String
    let currentOffset: Int

    internal init(query: String, currentOffset: Int) {
        self.query = query
        self.currentOffset = currentOffset
    }

    internal init(_ query: AddictiveSearchQuery) {
        self.query = query.query
        self.currentOffset = query.startIndex
    }
}

struct SharedFocusMessage: Codable {
    let content: AddictiveContent?
}

struct SharedRatingMessage: Codable {
    let contentHostID: String
    let rating: Int
}
