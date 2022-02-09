import Combine
import Giphy
import Network
import XCTest

final class LiveAPITests: XCTestCase {

    override func setUpWithError() throws {
        checkInternet()
    }

    func testGiphySearch_HappyPath_DeliversGRatedRainbowGIFsInEnglish() throws {
        var test = setupTest()
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: nil, language: nil)
        let sut = test.api.search

        sut(testCase)
            .sinkAssertNoError(completesExp: test.exp) { result in
                XCTAssertEqual(result.gifs.count, 50)
                XCTAssertEqual(result.startIndex, 0)
                XCTAssertGreaterThan(result.resultsCount, 500)
            }
            .store(in: &test.subs)

        wait(for: [test.exp], timeout: timeout)
    }

    func testGiphySearch_UnsupportedLanguageCode_StillDeliversResults() throws {
        var test = setupTest()
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: nil, language: "covfefe")
        let sut = test.api.search

        sut(testCase)
            .sinkAssertNoError(completesExp: test.exp) { result in
                XCTAssertEqual(result.gifs.count, 50)
                XCTAssertEqual(result.startIndex, 0)
                XCTAssertGreaterThan(result.resultsCount, 500)
            }
            .store(in: &test.subs)

        wait(for: [test.exp], timeout: timeout)
    }

    func testGiphySearch_Pagination_IllegalStartIndex_DeliversEmptySuccess() throws {
        var test = setupTest()
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: Int32.max, rating: nil, language: nil)
        let sut = test.api.search

        sut(testCase)
            .sinkAssertNoError(completesExp: test.exp) { result in
                XCTAssertEqual(result.gifs.count, 0)
                XCTAssertEqual(result.startIndex, 0)
                XCTAssertEqual(result.resultsCount, 0)
            }
            .store(in: &test.subs)

        wait(for: [test.exp], timeout: timeout)
    }

    func testGiphySearch_Pagination_Increments() throws {
        var test = setupTest()
        let sut = test.api.search
        let pageSize = 50
        let query: (Int) -> GiphySearchQuery = { index in
            GiphySearchQuery(gRatedEnglishRainbowsStartIndex: Int32(index * pageSize), rating: nil, language: nil)
        }

        var currentIndex = 0
        (1...4).publisher
            .map(query)
            .flatMap(maxPublishers: .max(1), sut)
            .sinkAssertNoError(completesExp: test.exp) { result in
                currentIndex += 1
                XCTAssertEqual(result.gifs.count, pageSize)
                XCTAssertEqual(result.startIndex, currentIndex * pageSize)
                XCTAssertGreaterThan(result.resultsCount, pageSize)
            }
            .store(in: &test.subs)

        wait(for: [test.exp], timeout: timeout)
    }

    func testGiphySearch_SimultaneousRequests_SucceedNoThrottling() throws {
        var test = setupTest()
        let testCase = GiphySearchQuery(gRatedEnglishRainbowsStartIndex: 0, rating: nil, language: nil)
        let sut = test.api.search
        let target = 50
        test.exp.expectedFulfillmentCount = target + 1

        (0...target).publisher
            .flatMap(maxPublishers: .max(target)) { _ in sut(testCase) }
            .sinkAssertNoError(completesExp: test.exp) { result in
                test.exp.fulfill()
                XCTAssertEqual(result.gifs.count, 50)
                XCTAssertEqual(result.startIndex, 0)
                XCTAssertGreaterThan(result.resultsCount, 50)
            }
            .store(in: &test.subs)

        wait(for: [test.exp], timeout: 6)
    }

    var network: NWPathMonitor? = nil
}

private func setupTest() -> (
    session: URLSession,
    api: GiphyService,
    subs: Set<AnyCancellable>,
    exp: XCTestExpectation
) {
    let sut = makeGiphyAPIWithEphemeralSession()
    return (sut.session, sut.api, .init(), .init(description: "Internet response"))
}



extension LiveAPITests {
    private func checkInternet() {
        var status: NWPath.Status = network?.currentPath.status ?? .requiresConnection
        let exp = XCTestExpectation()

        if network == nil {
            network = NWPathMonitor()
            network?.pathUpdateHandler = {
                status = $0.status
                exp.fulfill()
            }
            network?.start(queue: DispatchQueue.main)
        }

        if status == .satisfied { return }
        wait(for: [exp], timeout: 5)
        guard status == .satisfied else {
            XCTFail("These tests require an internet connection.")
            return
        }
    }
}
