@testable import AddictiveServices
import Combine
import XCTest

// Should test behaviors of each integration (e.g., CoreData, Giphy API)

final class GiphyServiceTests: XCTestCase {

    func testRemoteSearch_URLService_UsesInMemoryAndDiskCache() {
        let sut = DevelopmentAppLoader().createServices()

        // Prepare
        let testStartDate = Date()
        sut.dataTaskService.configuration.urlCache?.removeAllCachedResponses()
        XCTAssertEqual(sut.dataTaskService.configuration.urlCache?.currentMemoryUsage, 0)
        let waitForResult = XCTestExpectation()
        var subs = Set<AnyCancellable>()

        // Act
        sut.remote.search(.init(query: "diceroll\(Int32.random(in: 0..<Int32.max))", language: nil, startIndex: 0))
            .sink { completion in
                switch completion {
                case .failure(let error): XCTFail(error.localizedDescription)
                case .finished: waitForResult.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &subs)

        wait(for: [waitForResult], timeout: 5)
        XCTAssertGreaterThan(sut.dataTaskService.configuration.urlCache?.currentMemoryUsage ?? 0, 0)
        XCTAssertGreaterThan(sut.dataTaskService.configuration.urlCache?.currentDiskUsage ?? 0, 0)

        sut.dataTaskService.configuration.urlCache?.removeCachedResponses(since: testStartDate)
    }
}
