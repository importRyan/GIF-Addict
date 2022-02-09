import Foundation
import CoreData

public struct AddictiveCoreData {
    private init() {}

    internal static let momName = "AddictiveContent"

    public static func isCloudAvailable() -> Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }

    public static func isTesting() -> Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}


// MARK: - Core Data Configs

public struct PersistenceConfiguration {

    let modelName: String = AddictiveCoreData.momName
    public let cloudIdentifier: String

    public init(cloudIdentifier: String) {
        self.cloudIdentifier = cloudIdentifier
    }
}

extension StackManager {

    /// Loads the MOM from the package bundle
    static func model(for name: String) -> NSManagedObjectModel {
        let ext = "momd"
        guard let url = Bundle.module.url(forResource: name, withExtension: ext)
        else { fatalError("Resource not found for: \(name).\(ext)") }
        guard let model = NSManagedObjectModel(contentsOf: url)
        else { fatalError("Cannot load NSManagedObjectModel: \(url)") }
        return model
    }
}

open class PersistentContainer: NSPersistentContainer {
    override open class func defaultDirectoryURL() -> URL {
        super.defaultDirectoryURL()
            .appendingPathComponent("CoreDataModel")
    }
}

open class PersistentCloudKitContainer: NSPersistentCloudKitContainer {
    override open class func defaultDirectoryURL() -> URL {
        super.defaultDirectoryURL()
            .appendingPathComponent("CoreDataModel")
    }
}
