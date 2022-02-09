import XCTest
@testable import Giphy

/// With more time, further unit test GetGIFs api
///
final class UnitTests: XCTestCase {

    func testAPIKey_Accepted() throws {
        let sut = GiphyService(
            key: testAPIKey,
            dataTaskService: GiphyMockDataTaskService.shared
        ).config.key
        XCTAssertEqual(sut, testAPIKey)
    }

    func testGetGIFsEndpointPath_IsValid() throws {
        let sut: some Endpoint = GetGIFsEndpoint(gifIDs: [])
        XCTAssertEqual(sut.path.first, "/")
    }

    func testSearchEndpointPath_IsValid() throws {
        let sut: some Endpoint = SearchEndpoint(query: .init())
        XCTAssertEqual(sut.path.first, "/")
    }

    func testURLResponseValidation_ThrowsOnGiphy404() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 404))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .wrongEndpoint)
        }
    }

    func testURLResponseValidation_ThrowsOnGiphy403() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 403))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .blocked)
        }
    }

    func testURLResponseValidation_ThrowsOnGiphy400() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 400))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .badRequest)
        }
    }

    func testURLResponseValidation_ThrowsOnGiphy429() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 429))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .usageLimitReached)
        }
    }

    func testURLResponseValidation_ThrowsOnGiphyUnexpectedCode() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 000))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .unexpectedStatusCode(000))
        }
    }

    func testURLResponseValidation_ThrowsOnEmptyData() throws {
        let testCase: (Data, URLResponse) = (Data(), mockResponse(statusCode: 200))
        let sut = GiphyService.validateURLResponse
        XCTAssertThrowsError(try sut(testCase), "") { error in
            let error = try? XCTUnwrap(error as? GiphyError)
            XCTAssertEqual(error, .emptyData)
        }
    }

    func testURLResponseValidation_Giphy200_RecoversData() throws {
        let exp = "fake".data(using: .utf8)!
        let testCase: (Data, URLResponse) = (exp, mockResponse(statusCode: 200))
        let sut = GiphyService.validateURLResponse
        let result = try XCTUnwrap(try sut(testCase))
        XCTAssertEqual(exp, result)
    }

    func testSearchEndpoint_2022_GeneratesExpectedURL() throws {
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0)
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=0&rating=g&lang=en&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }

    func testSearchEndpoint_2022_AdvancesPaginationIndex() throws {
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 666)
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=666&rating=g&lang=en&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }

    func testSearchEndpoint_2022_ChangesLanguage() throws {
        var testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0)
        testCase.languageISO639 = "jp"
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=0&rating=g&lang=jp&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }

    func testSearchEndpoint_2022_ChangesRating() throws {
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: .y)
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=0&rating=y&lang=en&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }

    func testSearchEndpoint_2022_ExcludesRating() throws {
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: nil)
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=0&lang=en&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }

    func testSearchEndpoint_2022_ExcludesLanguage() throws {
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: nil, language: nil)
        let exp = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6&q=rainbows&limit=50&offset=0&bundle=messaging_non_clips")!
        let sut = SearchEndpoint(query: testCase)
        let result = testConfig.buildURL(for: sut)
        AssertURLsEquivalent(exp: exp, result)
    }
}

private func  mockResponse(from url: String = "fakeURL", statusCode: Int = 200, httpVersion: String = "HTTP/1.1", header: [String:String] = [:]) -> HTTPURLResponse {
    GiphyMockDataTaskService.shared.createMockHTTPResponse(from: url, statusCode: statusCode, httpVersion: httpVersion, header: header)
}
