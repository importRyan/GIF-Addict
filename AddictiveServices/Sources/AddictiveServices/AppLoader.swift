import Addiction
import Foundation
import Giphy
import AddictiveCoreData

public protocol AppLoader {
    init(environment: [String:String], flags: [String])
    func createServices() -> ServicesContainer
}

// MARK: - The one loader

public struct DevelopmentAppLoader: AppLoader {
    public init(environment: [String:String] = ProcessInfo.processInfo.environment,
                flags: [String] = ProcessInfo.processInfo.arguments) {
        // Not used in demo
    }
}

public extension DevelopmentAppLoader {

    func createServices() -> ServicesContainer {

        let dataTasks = createURLSessionWithOnDiskCache()

        let content: ContentService = GiphyService(
            key: "8UB9ywOS8w8uQ5DiEm2SCSmVvIEGkah6",
            dataTaskService: dataTasks
        )

        let cloudKitID = "iCloud.ryanferrell.GIF-Addict"
        let stack = CloudPersistenceManager(configuration: .init(cloudIdentifier: cloudKitID))
        let local = AddictiveCoreDataService(coreDataStack: stack, useBackgroundContext: true)
        let services = ServicesContainer(content, local, dataTasks)

        return services
    }

    func createURLSessionWithOnDiskCache() -> URLSession {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent("URLSessionCache")
        let cache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 300_000_000, directory: diskCacheURL)

        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad

        return URLSession(configuration: config)
    }
}
