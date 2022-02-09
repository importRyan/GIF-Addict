import Foundation

protocol Endpoint {
    associatedtype Response: Codable
    /// Must begin with "/" or URLComponents -> URL will crash
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    func makeEmptyRecoveryResponse() -> Response
}
