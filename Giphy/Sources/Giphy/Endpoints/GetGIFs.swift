import Foundation

struct GetGIFsEndpoint: Endpoint {
    typealias Response = PaginatedResponse

    let path = "/v1/gifs"
    let queryItems: [URLQueryItem]

    init(gifIDs: [String]) {
        let csv = gifIDs.joined(separator: ",")
        self.queryItems = [.init(name: "ids", value: csv)]
    }

    func makeEmptyRecoveryResponse() -> PaginatedResponse {
        .emptyResponse
    }
}
