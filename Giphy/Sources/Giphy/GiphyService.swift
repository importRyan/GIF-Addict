import Foundation
import Combine

public final class GiphyService {

    let config: ServiceConfig
    weak var dataTaskService: GiphyDataTaskService?

    public lazy private(set) var supportedLanguageCodes: Set<String> = Set(GiphySupportedLanguagesISO631.allCases.map(\.rawValue))

    public init(key: String, dataTaskService: GiphyDataTaskService) {
        self.config = NoUserTrackingConfig(key: key)
        self.dataTaskService = dataTaskService
    }
}

public extension GiphyService {

    /// Find GIFs matching a keyword query with a few filters
    func search(_ query: GiphySearchQuery) -> AnyPublisher<GiphySearchResult, Error> {
        fetch(SearchEndpoint(query: query))
            .map(GiphySearchResult.init)
            .eraseToAnyPublisher()
    }

    /// Try to get the latest info for up to 50 gif IDs
    func getGIF(ids: [GiphyGIF.ID]) -> AnyPublisher<[GiphyGIF], Error> {
        fetch(GetGIFsEndpoint(gifIDs: ids))
            .map { $0.data.compactMap(GiphyGIF.init) }
            .eraseToAnyPublisher()
    }

    /// Try to get the latest info for one particular GIF id
    func getGIF(id: GiphyGIF.ID) -> AnyPublisher<GiphyGIF, Error> {
        getGIF(ids: [id])
            .tryMap { results -> GiphyGIF in
                guard let result = results.first
                else { throw GiphyError.gifNotFound }
                return result
            }
            .eraseToAnyPublisher()
    }
}

extension GiphyService {

    func fetch<E: Endpoint>(_ endpoint: E) -> AnyPublisher<E.Response, Error> {
        let url = config.buildURL(for: endpoint)

        guard let session = dataTaskService else {
            return Fail(outputType: E.Response.self, failure: GiphyError.dataTaskServiceNil)
                .eraseToAnyPublisher()
        }
        return session
            .dataTask(for: .init(url: url))
            .retry(1)
            .tryMap(Self.validateURLResponse)
            .handleEvents(receiveOutput: { output in
                assert(Thread.isMainThread == false)
            })
            .decode(type: E.Response.self, decoder: JSONDecoder())
        // Record JSON decoding issues
            .handleEvents(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }

                if let decoding = error as? DecodingError {
                    NSLog(decoding.failureReason ?? "Unknown reason")
                    NSLog(decoding.localizedDescription)

                    switch decoding {
                        case .typeMismatch(let any, let context):
                        NSLog("TypeMismatch \(any.self)")
                        NSLog("Context \(context.codingPath)")

                        case .valueNotFound(let any, let context):
                        NSLog("ValueNotFound \(any.self)")
                        NSLog("Context \(context.codingPath)")

                        case .keyNotFound(let codingKey, let context):
                        NSLog("KeyNotFound \(codingKey.stringValue)")
                        NSLog("Context \(context.codingPath)")

                        case .dataCorrupted(let context):
                        NSLog("DataCorrupt \(context.codingPath)")

                    @unknown default:
                        NSLog("@unknown Decoding Error")
                    }
                }
            })
//        // Don't error out on these issues
//            .tryCatch { error -> AnyPublisher<E.Response, Error> in
//                guard error is DecodingError else { throw error }
//                return Just(endpoint.makeEmptyRecoveryResponse())
//                    .setFailureType(to: Error.self)
//                    .eraseToAnyPublisher()
//            }
            .eraseToAnyPublisher()
    }
}
