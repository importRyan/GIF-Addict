import CoreData
import XCTest
@testable import AddictiveCoreData

final class CoreDataModelTests: XCTestCase {

    var coredata: TemporaryPersistenceManager!

    override func setUp() {
        super.setUp()
        let config = PersistenceConfiguration(
            cloudIdentifier: ""
        )
        self.coredata = TemporaryPersistenceManager(configuration: config)
    }

    override func tearDown() {
        super.tearDown()
        self.coredata = nil
    }

    func testLoadsTemporaryStore() throws {
        XCTAssertEqual(coredata.container.name, "AddictiveContent")
        XCTAssertEqual(coredata.container.persistentStoreDescriptions.first?.type, NSInMemoryStoreType)
    }

    func testDetectsTesting() {
        XCTAssertEqual(AddictiveCoreData.isTesting(), true)
    }

    // MARK: - Quick checks on model versioning

    func testModelEntities_Exist() throws {
        let allEntities = Set(coredata.container.managedObjectModel.entitiesByName.keys)
        XCTAssertEqual(allEntities, ["ContentMO"])
    }

    func testContentEntity_HasExpectedAttributes() throws {
        let allProps = coredata.propsByName(forEntity: "ContentMO")
        let exp = ["trending", "repOriginalURL", "rating", "repOriginalHeight", "host", "title", "hostID", "repOriginalWidth", "repPreviewURL", "sourceURL", "sourceLabel", "created"]
        XCTAssertEqual(Set(allProps.keys), Set(exp))
    }
}

private extension TemporaryPersistenceManager {
    func propsByName(forEntity: String) -> [String : NSPropertyDescription] {
        container.managedObjectModel.entitiesByName[forEntity]?.propertiesByName ?? [:]
    }
}
