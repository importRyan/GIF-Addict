import Foundation

struct AnalyticsObject: Codable {
    let onload, onclick, onsent: RegisterActionEndpoint

    struct RegisterActionEndpoint: Codable {
        let url: String
    }
}
