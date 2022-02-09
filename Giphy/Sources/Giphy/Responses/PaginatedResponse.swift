import Foundation

struct PaginatedResponse: Codable {
    let data: [GIFObject]
    let pagination: PaginationObject
    //    let meta: MetaObject
}


extension PaginatedResponse {
    static var emptyResponse: Self {
        .init(data: [], pagination: .init(totalCount: 0, count: 0, offset: 0))
    }
}
