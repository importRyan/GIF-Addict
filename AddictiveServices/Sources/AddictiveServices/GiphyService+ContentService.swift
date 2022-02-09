// Copyright 2022 Ryan Ferrell

import Addiction
import Combine
import Foundation
import Giphy

extension GiphyService: ContentService {

    public var identifier: ContentServiceChoices { .remote }

    public func search(_ query: AddictiveSearchQuery) -> AnyPublisher<AddictiveSearchResult, Error> {
        self.search(.init(query))
            .map(\.mapped)
            .eraseToAnyPublisher()
    }

    public func getContent(ids: [AddictiveContent.ID]) -> AnyPublisher<[AddictiveContent], Error> {
        self.getGIF(ids: ids)
            .map { $0.map(\.mapped) }
            .eraseToAnyPublisher()
    }

    public func getContent(id: AddictiveContent.ID) -> AnyPublisher<AddictiveContent, Error> {
        self.getGIF(id: id)
            .map(\.mapped)
            .eraseToAnyPublisher()
    }
}

extension GiphySearchQuery {
    init(_ addiction: AddictiveSearchQuery) {
        self.init(query: addiction.query,
                  startAtResultIndex: Int32(addiction.startIndex),
                  rating: nil,
                  languageISO639: addiction.language)
    }
}

extension GiphySearchResult {
    var mapped: AddictiveSearchResult {
        .init(startIndex: self.startIndex,
              resultsCount: self.resultsCount,
              results: self.gifs.map(\.mapped))
    }
}

extension GiphyGIF {
    var mapped: AddictiveContent {
        .init(hostID: self.id,
              host: "Giphy",
              title: self.title,
              sourceLabel: self.sourceDomain,
              sourceURL: self.sourceURL,
              created: self.created,
              trendingDate: self.trendingDate,
              representations: self.representations.mapped,
              rating: 0
        )
    }
}

extension GiphyGIF.Representations {
    var mapped: AddictiveContent.RemoteRepresentations {
        .init(originalURL: self.originalURL,
              originalSize: self.originalSize,
              previewURL: self.previewURL)
    }
}
