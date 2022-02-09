import Foundation
import Combine

public class QueryComposer: ObservableObject {

    @Published public internal(set) var query = ""
    @Published public var language: ISO6391LanguageCode?
    @Published public internal(set) var languages: [ISO6391LanguageCode]

    internal weak var coordinator: QueryDelegate?
    private var typingSub: AnyCancellable?

    internal init(coordinator: QueryDelegate?, languages: Set<ISO6391LanguageCode>) {
        self.coordinator = coordinator
        self.languages = languages.sorted()

        if let currentLanguage = Locale.current.languageCode, languages.contains(currentLanguage) {
            self.language = currentLanguage
        } else {
            self.language = nil
        }

        submitWhileTyping()
    }
}

extension QueryComposer: QueryComposing {

    public func updateQuery(text: String) {
        query = text
    }

    public func submitQuery() {
        let newQuery = AddictiveSearchQuery(query: query, language: language, startIndex: 0)
        coordinator?.userSubmittedNewQuery(newQuery)
    }

    public func resetQuery() {
        query = ""
        submitQuery()
    }
}

private extension QueryComposer {

    func submitWhileTyping() {
        typingSub = $query
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.isEmpty == false }
            .sink { [weak self] newSearch in
                self?.submitQuery()
            }
    }
}
