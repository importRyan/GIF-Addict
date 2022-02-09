import Foundation
import Combine

public protocol GiphyDataTaskService: AnyObject {
    func dataTask(for request: URLRequest) -> GiphyDataTaskPublisher
}

public typealias GiphyDataTakePublisherOutput = (data: Data, response: URLResponse)
public typealias GiphyDataTaskPublisher = AnyPublisher<GiphyDataTakePublisherOutput, URLError>

extension URLSession: GiphyDataTaskService {
    public func dataTask(for request: URLRequest) -> GiphyDataTaskPublisher {
        self.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

// MARK: - Mock

/// Fill with sendable data. Monitor received requests.
///
public class GiphyMockDataTaskService: GiphyDataTaskService {
    public init() {}
    public static let shared = GiphyMockDataTaskService.init()

    public var sendData: Data = .init()
    public lazy var sendURLResponse: URLResponse = createMockHTTPResponse()
    public var sendError: URLError? = nil
    public var sendDelay: DispatchQueue.SchedulerTimeType.Stride = 0
    public var sendQueue: DispatchQueue = .init(label: "GiphyMock")

    public var receivedRequests: [URLRequest] = []

    public func dataTask(for request: URLRequest) -> GiphyDataTaskPublisher {
        receivedRequests.append(request)

        if let error = sendError {
            return Fail(outputType: GiphyDataTakePublisherOutput.self, failure: error)
                .eraseToAnyPublisher()
        } else {
            return Just((sendData, sendURLResponse))
                .setFailureType(to: URLError.self)
                .delay(for: sendDelay, tolerance: 0, scheduler: sendQueue, options: nil)
                .eraseToAnyPublisher()
        }
    }

    public func createMockHTTPResponse(
        from url: String = "fakeURL",
        statusCode: Int = 200,
        httpVersion: String = "HTTP/1.1",
        header: [String:String] = [:]
    ) -> HTTPURLResponse {

        .init(url: .init(string: url)!,
              statusCode: statusCode,
              httpVersion: httpVersion,
              headerFields: header)!
    }
}
