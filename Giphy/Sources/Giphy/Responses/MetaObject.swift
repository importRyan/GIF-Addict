import Foundation

struct MetaObject: Codable {
    let status: GiphyResponseCode?
    let msg: String // "OK"
                    /// Unique ID  for this response
    let responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

enum GiphyResponseCode: Int, Codable {
    case ok = 200
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429
}

extension GiphyError {

    init?(responseCode: Int) {
        switch responseCode {
        case GiphyResponseCode.ok.rawValue, nil: return nil
        case GiphyResponseCode.badRequest.rawValue: self = .badRequest
        case GiphyResponseCode.forbidden.rawValue: self = .blocked
        case GiphyResponseCode.notFound.rawValue: self = .wrongEndpoint
        case GiphyResponseCode.tooManyRequests.rawValue: self = .usageLimitReached
        default: self = .unexpectedStatusCode(responseCode)
        }
    }
}
