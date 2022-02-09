import XCTest
@testable import Giphy

let testAPIKey = "8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6"
let testConfig = NoUserTrackingConfig(key: testAPIKey)
let timeout = TimeInterval(30)

func makeGiphyAPIWithEphemeralSession() -> (session: URLSession, api: GiphyService) {
    let session = URLSession(configuration: .ephemeral)
    let api = GiphyService(key: testAPIKey, dataTaskService: session)
    return (session, api)
}


extension GiphySearchQuery {

    init(gRatedEnglishRainbowsStartIndex index: Int32, rating: GiphyMPAARating? = .g, language: String? = "en") {
        self.init(query: "rainbows", startAtResultIndex: index, rating: rating, languageISO639: language)
    }
}
