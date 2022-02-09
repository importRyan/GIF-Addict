import XCTest
@testable import AddictiveCoreData

final class ServiceTests: XCTestCase {

    var coredata: TemporaryPersistenceManager!
    var sut: AddictiveCoreDataService!

    override func setUp() {
        super.setUp()
        let config = PersistenceConfiguration(
            cloudIdentifier: ""
        )
        self.coredata = TemporaryPersistenceManager(configuration: config)
        self.sut = AddictiveCoreDataService(coreDataStack: self.coredata, useBackgroundContext: false)
    }

    override func tearDown() {
        super.tearDown()
        self.coredata = nil
        self.sut = nil
    }

    func testPersistContent_MapsModelObjectCorrectly() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())

        // Act
        let sutMO = testCase.convertToCoreDataMO(in: sut.context)

        XCTAssertEqual(testCase.rating, .init(sutMO.rating))
        XCTAssertEqual(testCase.hostID, sutMO.hostID)
        XCTAssertEqual(testCase.host, sutMO.host)
        XCTAssertEqual(testCase.title, sutMO.title)
        XCTAssertEqual(testCase.sourceLabel, sutMO.sourceLabel)
        XCTAssertEqual(testCase.sourceURL, sutMO.sourceURL)
        XCTAssertEqual(testCase.created, sutMO.created)
        XCTAssertEqual(testCase.trendingDate, sutMO.trending)
        XCTAssertEqual(testCase.repOriginalURL, sutMO.repOriginalURL)
        XCTAssertEqual(testCase.repPreviewURL, sutMO.repPreviewURL)
        XCTAssertEqual(testCase.repOriginalSize.width, .init(sutMO.repOriginalWidth))
        XCTAssertEqual(testCase.repOriginalSize.height, .init(sutMO.repOriginalHeight))
    }

    func testPersistContent_AddsNewContent_InViewContext() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context)

        // Act
        sut.persist(content: testCase)

        let results = sut.fetchAllContent().results
        let result = try XCTUnwrap(results.first)
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(testCase, result)
        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(error, "CoreData did not save.")
        }
        XCTAssertEqual(sut.context.registeredObjects.count, 1)
    }

    func testPersistContent_AddsNewContentInBackgroundContext_SavesToViewContext() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        // Setup service in background
        let background = AddictiveCoreDataService(coreDataStack: self.coredata, useBackgroundContext: true)
        // Expect two CoreData save notifications
        expectation(forNotification: .NSManagedObjectContextDidSave, object: self.coredata.viewContext)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: background.context)

        // Act
        background.persist(content: testCase)

        // Assert exact result in main thread context
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "CoreData did not save.")
        }
        let results = sut.fetchAllContent().results
        let result = try XCTUnwrap(results.first)
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(testCase, result)
        XCTAssertEqual(sut.context.registeredObjects.count, 1)
    }

    func testPersistContent_UpdatesExistingContentRating() throws {
        var testCase = makeNewContentTestCase1(rating: .randomInt16())
        sut.persist(content: testCase)

        // Act
        testCase.rating -= 1
        sut.persist(content: testCase)

        let results = sut.fetchAllContent().results
        let result = try XCTUnwrap(results.first)
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(testCase, result)
        XCTAssertEqual(sut.context.registeredObjects.count, 1)
    }

    func testDelete_RemovesContent() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        sut.persist(content: testCase)

        // Act
        sut.delete(content: testCase)

        let results = sut.fetchAllContent().results
        XCTAssertEqual(results.count, 0)
        XCTAssertEqual(sut.context.registeredObjects.count, 0)
    }

    func testQuery_DoesNotFindMismatchedTitles() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        expectation(forNotification: .NSManagedObjectContextDidSave, object: sut.context)
        let _ = sut.persist(content: testCase)

        // Act
        let query = AddictiveCoreDataSearchQuery(query: "def", offset: 0, batchLimit: nil)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 0)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results, [])

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(error, "CoreData did not save.")
        }
    }

    func testQuery_FindsMatchingTitles_IgnoringOthers() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        let testCase2 = makeNewContentTestCase2(rating: .randomInt16())
        sut.persist(newContent: [testCase, testCase2])

        // Act
        let query = AddictiveCoreDataSearchQuery(query: testCase.title, offset: 0, batchLimit: nil)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 1)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results, [testCase])
    }

    func testQuery_FindsPrefixedTitles() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        let testCase2 = makeNewContentTestCase2(rating: .randomInt16())
        sut.persist(newContent: [testCase, testCase2])

        // Act
        let needle = String(testCase.title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 0, batchLimit: nil)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 1)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results, [testCase])
    }

    func testQuery_FindsSuffixedTitles() throws {
        let testCase = makeNewContentTestCase1(rating: 5)
        let testCase2 = makeNewContentTestCase2(rating: 1)
        sut.persist(newContent: [testCase, testCase2])

        // Act
        let needle = String(testCase.title.suffix(3))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 0, batchLimit: nil)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 2)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results, [testCase, testCase2])
    }

    func testQuery_FindsSubstringMatchTitles() throws {
        let testCase = makeNewContentTestCase1(rating: .randomInt16())
        let testCase2 = makeNewContentTestCase2(rating: .randomInt16())
        sut.persist(newContent: [testCase, testCase2])

        // Act
        let needle = String(testCase.title.prefix(5).suffix(3))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 0, batchLimit: nil)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 1)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results, [testCase])
    }

    func testQuery_ObeysBatchLimit_OrderingHighestRankedFirst() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 0, batchLimit: 10)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, 0)
        XCTAssertEqual(result.results.map(\.rating), (90..<100).reversed().map{$0} )
    }

    func testQuery_ObeysBatchIndexAndLimit_OrderingHighestRankedFirst() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 5, batchLimit: 10)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, 5)
        XCTAssertEqual(result.results.map(\.rating), (85..<95).reversed().map{$0} )
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeStartIndex() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 101, batchLimit: 0)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, 101)
        XCTAssertEqual(result.results, [] )
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeStartIndex_IntMax() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: .max, batchLimit: 0)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, .max)
        XCTAssertEqual(result.results, [] )
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeEndIndex() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 99, batchLimit: 1000)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, 99)
        XCTAssertEqual(result.results.map(\.rating), [0])
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeEndIndex_IntMax() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: 99, batchLimit: .max)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, 99)
        XCTAssertEqual(result.results.map(\.rating), [0])
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeStartAndEndIndexes_IntMax() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: .max, batchLimit: .max)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, .max)
        XCTAssertEqual(result.results, [])
    }

    func testQuery_ObeysBatchIndexAndLimit_OutOfRangeStartAndEndIndexes_IntMin() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: .min, batchLimit: .min)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, .min)
        XCTAssertEqual(result.results, [])
    }

    func testQuery_ObeysBatchIndexAndLimit_ReversedRange() throws {
        let testCases = make100RatingIncrementsOfTestCase1()
        sut.persist(newContent: testCases)

        // Act
        let needle = String(testCases[0].title.prefix(5))
        let query = AddictiveCoreDataSearchQuery(query: needle, offset: .max, batchLimit: .min)
        let result = sut.fetch(query: query)

        XCTAssertEqual(result.totalResults, 100)
        XCTAssertEqual(result.offset, .max)
        XCTAssertEqual(result.results, [])
    }
}

// MARK: - Helpers

extension ServiceTests {

    private func add100TestCase1RatingIncrements(to service: AddictiveCoreDataService) {
        let exp = expectation(forNotification: .NSManagedObjectContextDidSave, object: self.coredata.viewContext)
        exp.expectedFulfillmentCount = 2
        let cases = make100RatingIncrementsOfTestCase1()
        let _ = service.persist(content: cases[0])

        let _ = service.persist(content: cases[1])

        wait(for: [exp], timeout: 5)
        XCTAssertEqual(service.context.registeredObjects.count, 100)
    }
}

private func makeNewContentTestCase1(rating: Int) -> AddictiveCoreDataContent {
    AddictiveCoreDataContent(
        rating: rating,
        hostID: "abcd\(rating)",
        host: "contentServer",
        title: "Serious GIF",
        sourceLabel: "seriousNews",
        sourceURL: URL(string: "https://www.serioussourceurl.com"),
        created: Date(timeIntervalSince1970: 1),
        trendingDate: Date(timeIntervalSince1970: 2),
        repOriginalSize: .init(width: 3, height: 4),
        repOriginalURL: URL(string: "https://www.serioussourceurl.com/original.mp4")!,
        repPreviewURL: URL(string: "https://www.serioussourceurl.com/preview.mp4")!
    )
}

private func make100RatingIncrementsOfTestCase1() -> [AddictiveCoreDataContent] {
    (0..<100).map(makeNewContentTestCase1(rating:))
}

private func makeNewContentTestCase2(rating: Int) -> AddictiveCoreDataContent {
    AddictiveCoreDataContent(
        rating: rating,
        hostID: "efgh5678",
        host: "contentServer",
        title: "Funny GIF",
        sourceLabel: "seriousNews",
        sourceURL: URL(string: "https://www.serioussourceurl.com/B"),
        created: Date(timeIntervalSince1970: 5),
        trendingDate: Date(timeIntervalSince1970: 6),
        repOriginalSize: .init(width: 7, height: 8),
        repOriginalURL: URL(string: "https://www.serioussourceurl.com/originalB.mp4")!,
        repPreviewURL: URL(string: "https://www.serioussourceurl.com/previewB.mp4")!
    )
}

extension Int {
    static func randomInt16() -> Int {
        .random(in: 0..<Int(Int16.max))
    }
}
