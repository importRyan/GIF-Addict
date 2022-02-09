import Foundation
import Combine

public protocol ContentService: AnyObject {
    func search(_ query: AddictiveSearchQuery) -> AnyPublisher<AddictiveSearchResult, Error>
    func getContent(ids: [AddictiveContent.ID]) -> AnyPublisher<[AddictiveContent], Error>
    func getContent(id: AddictiveContent.ID) -> AnyPublisher<AddictiveContent, Error>
    var supportedLanguageCodes: Set<String> { get }
    var identifier: ContentServiceChoices { get }
}

public protocol LocalContentService: ContentService {
    func save(rating: Int, content: AddictiveContent)
    func delete(content: AddictiveContent)
}
