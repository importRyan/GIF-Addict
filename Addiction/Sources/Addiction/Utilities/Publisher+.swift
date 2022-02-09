import Foundation
import Combine

public extension Publisher {
    func receiveOnMain() -> AnyPublisher<Output,Failure> {
        receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}

extension Publisher where Output == ([AddictiveContent], AddictiveSearchResult), Failure == Error {

    func mergeLocalRatingsIntoSearchResultsInAscendingRatingOrder() -> AnyPublisher<AddictiveSearchResult, Error> {
        map { ratings, searchResult -> AddictiveSearchResult in
            Swift.print("MERGE", ratings)
            let ratedDict = ratings.hashMapBy(\.hostID)
            var prefix = [AddictiveContent]()
            var suffix = [AddictiveContent]()

            // Ratings and search results are BOTH already sorted by CoreData or the server in some ascending order
            // Run through the search results once, placing any rated items in the prefix
            for var result in searchResult.results {
                guard let rating = ratedDict[result.hostID]?.rating else {
                    suffix.append(result)
                    continue
                }
                result.rating = rating
                prefix.append(result)
            }

            return .init(startIndex: searchResult.startIndex,
                         resultsCount: searchResult.resultsCount,
                         results: prefix + suffix)
        }
        .eraseToAnyPublisher()
    }
}
