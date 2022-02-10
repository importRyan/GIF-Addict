@testable import Addiction
import Combine
import XCTest

final class ContentBrowserBehavioralTests: XCTestCase {

    func testInit_DoesNotTriggerServiceRequests() throws {
        let test = Test()
        XCTAssertEqual(0, test.remote.searchRequests.count)
        XCTAssertEqual(0, test.local.searchRequests.count)
        XCTAssertEqual(0, test.local.deleteRequests.count)
        XCTAssertEqual(0, test.local.saveRequests.count)
        XCTAssertEqual(0, test.local.getContentIDSRequests.count)
        XCTAssertEqual(0, test.local.getContentIDRequests.count)
    }

    func testEndlessScroll_DoesNotSubmitExcessQuery() throws {
        let test = Test()
        configureWithRemoteSearchResults(test)
        let startingRequests = (remote: test.remote.searchRequests.count, local: test.local.searchRequests.count)

        awaitPublisher(
            test.sut.$results.dropFirst(),
            count: nil,
            timeout: 1,
            trigger: {
                // Act
                test.sut.nextSearchResultPage()
            }, receiveValue: { exp, _ in
                /// Should not be reached
                exp.fulfill()
            }
        )

        XCTAssertEqual(startingRequests.remote, test.remote.searchRequests.count)
        XCTAssertEqual(startingRequests.local, test.local.searchRequests.count)
    }

    func testDoesNotSetNewContentSource_IfCurrentlyThatSource() throws {
        let test = Test()
        let priorState = configureWithLocalSearchResults(test)

        awaitPublisher(
            test.sut.objectWillChange,
            count: nil,
            timeout: 2,
            trigger: {
                // Act
                _ = test.sut.setContentSource(to: test.remote, restoring: priorState)
            }, receiveValue: { exp, _ in
                // Await
                XCTFail("Should not diff")
                exp.fulfill()
            }
        )
    }

    func testSetsNewContentSource_LocalNoPriorState() throws {
        let test = Test()
        configureWithRemoteSearchResults(test)

        var cachedState: BrowsingState?
        awaitPublisher(
            test.sut.objectWillChange,
            count: 1,
            timeout: 5,
            trigger: {
                // Act
                cachedState = test.sut.setContentSource(to: test.local, restoring: nil)
            }, receiveValue: { exp, _ in
                // Await
                guard test.sut.activeContentService?.identifier == .favorites else { return }
                exp.fulfill()
            }
        )

        XCTAssertEqual(cachedState?.nextFetchIndex, -27)
        XCTAssertEqual(cachedState?.results.count, 3)

        XCTAssertTrue(test.sut.activeContentService === test.local)
        XCTAssertEqual(test.sut.results, [])
        XCTAssertEqual(test.sut.currentQuery, nil)
        XCTAssertEqual(test.sut.totalResults, 0)
        XCTAssertEqual(test.sut.nextFetchIndex, -30)
        XCTAssertEqual(test.sut.mostRecentlyAppearedIndex, 0)
        XCTAssertEqual(test.sut.mostRecentlyDisappearedIndex, 0)
    }

    func testSetsNewContentSource_LocalWithPriorState() throws {
        let test = Test()
        let priorState = configureWithLocalSearchResults(test)

        awaitPublisher(
            test.sut.objectWillChange,
            count: 1,
            timeout: 5,
            trigger: {
                // Act
                _ = test.sut.setContentSource(to: test.local, restoring: priorState)
            }, receiveValue: { exp, _ in
                // Await
                guard test.sut.activeContentService?.identifier == .favorites else { return }
                exp.fulfill()
            }
        )

        XCTAssertTrue(test.sut.activeContentService === test.local)
        XCTAssertEqual(test.sut.results, priorState.results)
        XCTAssertEqual(test.sut.currentQuery, priorState.currentQuery)
        XCTAssertEqual(test.sut.totalResults, priorState.totalResults)
        XCTAssertEqual(test.sut.nextFetchIndex, priorState.nextFetchIndex)
        XCTAssertEqual(test.sut.mostRecentlyAppearedIndex, priorState.mostRecentlyAppearedIndex)
        XCTAssertEqual(test.sut.mostRecentlyDisappearedIndex, priorState.mostRecentlyDisappearedIndex)
        XCTAssertEqual(test.sut.isLoading, false)
    }

    func testSetsContentSourceX2_ReturnsToRemoteState() throws {
        let test = Test()
        configureWithRemoteSearchResults(test)

        XCTAssertFalse(test.sut.activeContentService === test.local)

        var cachedState: BrowsingState?
        awaitPublisher(
            test.sut.objectWillChange,
            count: 1,
            timeout: 5,
            trigger: {
                // Act
                cachedState = test.sut.setContentSource(to: test.local, restoring: nil)
            }, receiveValue: { exp, _ in
                // Await
                guard test.sut.activeContentService?.identifier == .favorites else { return }
                exp.fulfill()
            }
        )

        XCTAssertGreaterThan(cachedState!.results.count, 2)
        XCTAssertEqual(cachedState?.results.count, test.remote.content.value.count)

        var cachedLocalState: BrowsingState?
        awaitPublisher(
            test.sut.objectWillChange,
            count: 1,
            timeout: 5,
            trigger: {
                // Act
                cachedLocalState = test.sut.setContentSource(to: test.remote, restoring: cachedState)
            }, receiveValue: { exp, _ in
                // Await
                guard test.sut.activeContentService?.identifier == .favorites else { return }
                exp.fulfill()
            }
        )

        XCTAssertEqual(cachedLocalState?.nextFetchIndex, -30)
        XCTAssertEqual(cachedLocalState?.results.count, 0)

        XCTAssertTrue(test.sut.activeContentService === test.remote)
        XCTAssertEqual(test.sut.results, cachedState?.results)
        XCTAssertEqual(test.sut.currentQuery, cachedState?.currentQuery)
        XCTAssertEqual(test.sut.totalResults, cachedState?.totalResults)
        XCTAssertEqual(test.sut.nextFetchIndex, cachedState?.nextFetchIndex)
        XCTAssertEqual(test.sut.mostRecentlyAppearedIndex, cachedState?.mostRecentlyAppearedIndex)
        XCTAssertEqual(test.sut.mostRecentlyDisappearedIndex, cachedState?.mostRecentlyDisappearedIndex)
        XCTAssertEqual(test.sut.isLoading, false)
    }

}

private extension ContentBrowserBehavioralTests {

    class Test {
        let sut: ContentBrowserUseCase
        let local: SpyLocalContentService
        let remote: SpyContentService
        var subs = Set<AnyCancellable>()

        init(usingRemote: Bool = true) {
            self.local = .init()
            self.remote = .init()
            self.sut = .init(content: usingRemote ? remote : local, localService: local)
        }
    }

    func configureWithRemoteSearchResults(_ test: Test) {
        test.remote.loadDemoContent1()
        let exp = XCTestExpectation()
        test.sut
            .$results
            .sink { results in
                guard results.count == test.remote.content.value.count,
                      test.remote.content.value.count > 1 else { return }
                exp.fulfill()
            }.store(in: &test.subs)
        test.sut.search(newQuery: .init(query: "test", language: nil, startIndex: 0))
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(test.remote.searchRequests.count, 1)
        XCTAssertEqual(test.sut.results.count, test.remote.content.value.count)
    }

    func configureWithLocalSearchResults(_ test: Test) -> BrowsingState {
        test.local.loadDemoContent1()
        let priorState = BrowsingState(
            currentQuery: .init(query: "priorQuery", language: nil, startIndex: 0),
            results: test.local.content.value,
            totalResults: test.local.content.value.count,
            nextFetchIndex: 100,
            mostRecentlyAppearedIndex: 0,
            mostRecentlyDisappearedIndex: test.local.content.value.endIndex
        )
        return priorState
    }
}
