@testable import Addiction
import Combine
import XCTest

class SpyLocalContentService: SpyContentService, LocalContentService {

    var saveRequests: [(rating: Int, content: AddictiveContent)] = []
    var deleteRequests: [AddictiveContent] = []

    override var identifier: ContentServiceChoices { .favorites }

    func save(rating: Int, content: AddictiveContent) {
        saveRequests.append((rating, content))
        guard let targetIndex = self.content.value.firstIndex(where: { $0.id == content.id }) else { return }
        self.content.value[targetIndex] = content.withRating(rating)
    }

    func delete(content target: AddictiveContent) {
        deleteRequests.append(target)
        self.content.value = self.content.value.filter { $0.hostID != target.hostID }
    }

}

class SpyContentService: ContentService {

    // Mock database
    var content = CurrentValueSubject<[AddictiveContent], Never>([])
    // Spy
    var searchRequests: [AddictiveSearchQuery] = []
    var getContentIDSRequests: [[AddictiveContent.ID]] = []
    var getContentIDRequests: [AddictiveContent.ID] = []

    init() { }

    func loadDemoContent1() {
        self.content.value =  [
            makeDemoContent(rating: 0),
            makeDemoContent(rating: 1),
            makeDemoContent(rating: 2)
        ]
    }

    var supportedLanguageCodes: Set<String> { ["en", "zh"] }
    var identifier: ContentServiceChoices { .remote }

    func search(_ query: AddictiveSearchQuery) -> AnyPublisher<AddictiveSearchResult, Error> {
        searchRequests.append(query)
        return content
            .map { value in
            .init(
                startIndex: query.startIndex,
                resultsCount: value.count,
                results: value
            )}
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getContent(ids: [AddictiveContent.ID]) -> AnyPublisher<[AddictiveContent], Error> {
        getContentIDSRequests.append(ids)
        let set = Set(ids)
        return content
            .map { $0.filter { set.contains($0.id) } }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getContent(id: AddictiveContent.ID) -> AnyPublisher<AddictiveContent, Error> {
        getContentIDRequests.append(id)
        fatalError()
    }

}

func makeDemoContent(rating: Int) -> AddictiveContent {
    .init(hostID: "test\(rating)",
          host: "testing",
          title: "Funny Dogs",
          sourceLabel: "cats.com",
          sourceURL: nil, created: nil,
          trendingDate: nil,
          representations: makePlaceholderReps(),
          rating: rating
    )
}

func makePlaceholderReps() -> AddictiveContent.RemoteRepresentations {
    .init(originalURL: .init(fileURLWithPath: "test"),
          originalSize: .zero,
          previewURL: .init(fileURLWithPath: "test")
    )
}
