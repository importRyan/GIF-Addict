import Foundation
import CoreData

public protocol StackManager {

    /// The manager's viewContext
    var viewContext: NSManagedObjectContext { get }

    /// Create a derived context
    func newBackgroundContext() -> NSManagedObjectContext

    init(configuration: PersistenceConfiguration)
}


// MARK: - Implementation

extension StackManager {

    /// Saves one-deep to main thread context
    ///
    func save(toMain currentContext: NSManagedObjectContext) {
        if currentContext != viewContext {
            save(background: currentContext)
        } else {
            save(async: viewContext)
        }
    }

    /// Saves only the target context
    ///
    private func save(async context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("CoreData \(error) \(error.userInfo)")
            }
        }
    }

    /// Saves the background context and then the viewContext
    ///
    private func save(background context: NSManagedObjectContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("CoreData \(error) \(error.userInfo)")
            }
        }
        save(async: viewContext)
    }
}

public class CloudPersistenceManager: StackManager {

    internal var container: PersistentCloudKitContainer
    public var viewContext: NSManagedObjectContext { container.viewContext }

    public func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.undoManager = nil
        return context
    }

    required public init(
        configuration: PersistenceConfiguration
    ) {
        let model = Self.model(for: configuration.modelName)
        self.container = .init(name: configuration.modelName, managedObjectModel: model)

        // Configure
        self.container.viewContext.undoManager = nil
        configureOptions(in: self.container.persistentStoreDescriptions.first)

        self.container.loadPersistentStores(completionHandler: { (description, error) in
            // Better to handle for rout of space or load errors without crashing
            if let error = error as NSError? { fatalError("\(Self.self): \(description): \(error)  \(error.userInfo)") }
        })
    }
}

public class TemporaryPersistenceManager: StackManager {

    internal var container: PersistentContainer
    public var viewContext: NSManagedObjectContext { container.viewContext }

    public func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }

    required public init(
        configuration: PersistenceConfiguration
    ) {
        let model = Self.model(for: configuration.modelName)
        self.container = .init(name: configuration.modelName, managedObjectModel: model)

        // Configure
        self.container.viewContext.undoManager = nil
        let store = self.container.persistentStoreDescriptions.first
        store?.url = URL(fileURLWithPath: "/dev/null")
        store?.type = NSInMemoryStoreType
        configureOptions(in: store)

        self.container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? { fatalError("\(Self.self): \(description): \(error)  \(error.userInfo)") }
        })
    }
}



private func configureOptions(in store: NSPersistentStoreDescription?) {
    [NSMigratePersistentStoresAutomaticallyOption,
     NSInferMappingModelAutomaticallyOption,
     NSPersistentStoreRemoteChangeNotificationPostOptionKey,
     NSPersistentHistoryTrackingKey
    ].forEach { store?.setOption(true as NSNumber, forKey: $0) }
}

