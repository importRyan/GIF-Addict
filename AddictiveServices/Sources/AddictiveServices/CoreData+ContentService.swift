// Copyright 2022 Ryan Ferrell

import Addiction
import Combine
import Foundation
import AddictiveCoreData

extension AddictiveCoreDataService: LocalContentService {

    public func save(rating: Int, content: AddictiveContent) {
        persist(content: content.withRating(rating).convertedForCoreData)
    }

    public func delete(content: AddictiveContent) {
        self.delete(content: content.convertedForCoreData)
    }
}

extension AddictiveCoreDataService: ContentService {
    
    public var identifier: ContentServiceChoices { .favorites }

    public func search(_ query: AddictiveSearchQuery) -> AnyPublisher<AddictiveSearchResult, Error> {
        DeferredFuture { weakSelf, promise in
            guard let result = weakSelf?.fetch(query: .init(query)) else {
                promise(.failure(.unknown))
                return
            }
            promise(.success(result.mapped))
        }
    }

    public func getContent(ids: [AddictiveContent.ID]) -> AnyPublisher<[AddictiveContent], Error> {
        DeferredFuture { weakSelf, promise in
            guard let result = weakSelf?.fetch(contentServiceIDs: ids) else {
                promise(.failure(.unknown))
                return
            }
            promise(.success(result.results.map(\.mapped)))
        }
    }

    public func getContent(id: AddictiveContent.ID) -> AnyPublisher<AddictiveContent, Error> {
        DeferredFuture { weakSelf, promise in
            guard let result = weakSelf?.fetch(contentServiceIDs: [id]),
                  let first = result.results.first?.mapped else {
                      promise(.failure(.contentNotFound))
                      return
                  }
            promise(.success(first))
        }
    }

    public var supportedLanguageCodes: Set<String> { [] }

    private func DeferredFuture<O>(
        _ performBlock: @escaping (_ weakSelf: AddictiveCoreDataService?, _ promise: (Result<O, AddictiveServiceError>) -> Void) -> Void)
    -> AnyPublisher<O,Error> {
        Deferred { [weak self] in
            Future { [weak self] promise in
                performBlock(self, promise)
            }
        }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}

extension AddictiveCoreDataSearchQuery {
    init(_ addiction: AddictiveSearchQuery) {
        self.init(
            query: addiction.query,
            offset: addiction.startIndex,
            batchLimit: 50
        )
    }
}

extension AddictiveCoreDataSearchResult {
    var mapped: AddictiveSearchResult {
        .init(
            startIndex: self.offset,
            resultsCount: self.totalResults,
            results: self.results.map(\.mapped)
        )
    }
}

extension AddictiveCoreDataContent {
    var mapped: AddictiveContent {
        .init(hostID: self.hostID,
              host: self.host,
              title: self.title,
              sourceLabel: self.sourceLabel,
              sourceURL: self.sourceURL,
              created: self.created,
              trendingDate: self.trendingDate,
              representations: .init(
                originalURL: self.repOriginalURL,
                originalSize: self.repOriginalSize,
                previewURL: self.repPreviewURL
              ),
              rating: self.rating
        )
    }
}

private extension AddictiveContent {

    var convertedForCoreData: AddictiveCoreDataContent {
        .init(rating: self.rating,
              hostID: self.hostID,
              host: self.host,
              title: self.title,
              sourceLabel: self.sourceLabel,
              sourceURL: self.sourceURL,
              created: self.created,
              trendingDate: self.trendingDate,
              repOriginalSize: self.representations.originalSize,
              repOriginalURL: self.representations.originalURL,
              repPreviewURL: self.representations.previewURL
        )
    }
}

enum AddictiveServiceError: Error {
    case unknown
    case contentNotFound
}
