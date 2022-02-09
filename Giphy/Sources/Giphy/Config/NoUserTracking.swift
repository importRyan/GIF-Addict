import Foundation

struct NoUserTrackingConfig {

    /// Developer key
    let key: String
    /// Can request and store a unique user ID to customize responses, ignoring  in this project
    //    let userID: String? = nil

    init(key: String) {
        self.key = key
    }
}

extension NoUserTrackingConfig: ServiceConfig {

    func urlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.queryItems = [.init(name: "api_key", value: key)]
        return components
    }
}
