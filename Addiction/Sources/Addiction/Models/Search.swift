import Foundation

public typealias ISO6391LanguageCode = String

public struct AddictiveSearchQuery: Hashable, Equatable {
    public var query: String
    public var language: ISO6391LanguageCode?
    public var startIndex: Int

    public init(query: String, language: ISO6391LanguageCode?, startIndex: Int) {
        self.query = query
        self.language = language
        self.startIndex = startIndex
    }

    public init()  {
        self.init(query: "", language: nil, startIndex: 0)
    }
}

public struct AddictiveSearchResult: Equatable {
    public let startIndex: Int
    public let resultsCount: Int
    public let results: [AddictiveContent]

    public init(startIndex: Int, resultsCount: Int, results: [AddictiveContent]) {
        self.startIndex = startIndex
        self.resultsCount = resultsCount
        self.results = results
    }
}
