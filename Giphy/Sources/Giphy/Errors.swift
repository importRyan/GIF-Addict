import Foundation

public enum GiphyError: Error, Equatable {
    case badRequest
    case blocked
    case emptyData
    case gifNotFound
    case usageLimitReached
    case unexpectedStatusCode(Int)
    case url(URLError.Code)
    case wrongEndpoint
    case dataTaskServiceNil
}

extension GiphyService {

    static func validateURLResponse(from: (data: Data, response: URLResponse)) throws -> Data {
        guard let response = from.response as? HTTPURLResponse else {
            throw GiphyError.url(.badServerResponse)
        }
        if let error = GiphyError(responseCode: response.statusCode) {
            throw error
        }
        if from.data.isEmpty {
            throw GiphyError.emptyData
        }
        return from.data
    }
}
