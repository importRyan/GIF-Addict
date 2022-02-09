import Foundation

struct SearchEndpoint: Endpoint {
    typealias Response = PaginatedResponse

    let path = "/v1/gifs/search"
    let queryItems: [URLQueryItem]

    init(query: GiphySearchQuery) {
        self.queryItems = query.queryItems()
    }

    func makeEmptyRecoveryResponse() -> PaginatedResponse {
        .emptyResponse
    }
}

internal extension GiphySearchQuery {

    func queryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]()
        items.append(.init(name: "q", value: self.query))
        items.append(.init(name: "limit", value: String(self.maxResults)))
        items.append(.init(name: "offset", value: String(self.itemOffset)))

        if let rating = self.rating {
            items.append(.init(name: "rating", value: rating.rawValue))
        }
        if let language = self.languageISO639 {
            items.append(.init(name: "lang", value: language))
        }
        // Reduces image renditions sent.
        items.append(.init(name: "bundle", value: self.bundle))
        return items
    }
}
