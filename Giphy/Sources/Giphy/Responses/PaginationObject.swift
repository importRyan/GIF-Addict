import Foundation

struct PaginationObject: Codable {
    // Total results available (if relevant)
    let totalCount: Int?
    // Items returned in this response
    let count: Int
    // Page in  results
    let offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}
