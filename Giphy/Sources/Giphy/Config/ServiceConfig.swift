import Foundation

protocol ServiceConfig {
    var key: String { get }
    func urlComponents() -> URLComponents
}

extension ServiceConfig {

    /// Path begin with "/" or URLComponents -> URL will crash
    func buildURL<E: Endpoint>(for endpoint: E) -> URL {
        buildURLComponents(for: endpoint).url!
    }

    func buildURLComponents<E: Endpoint>(for endpoint: E) -> URLComponents {
        var components = self.urlComponents()
        components.path = endpoint.path
        components.queryItems?.append(contentsOf: endpoint.queryItems)
        return components
    }
}
