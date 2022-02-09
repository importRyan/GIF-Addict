import Foundation

public class ServicesContainer {

    public let remote: ContentService
    public let local: LocalContentService
    public let dataTaskService: URLSession

    public init(_ remote: ContentService, _ local: LocalContentService, _ dataTasks: URLSession) {
        self.remote = remote
        self.local = local
        self.dataTaskService = dataTasks
    }
}
