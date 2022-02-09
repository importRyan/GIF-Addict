import Foundation
import Combine

public class ContentRaterUseCase {

    @Published public private(set) var content: AddictiveContent? = nil
    @Published public private(set) var otherRatings: [(String, Int)] = []

    internal var didFetchRating = false
    private weak var localService: LocalContentService?
    private var setup: AnyCancellable? = nil

    internal init(localService: LocalContentService) {
        self.localService = localService
    }

    deinit {
        /// For now, skip using the undo manager
        guard let content = content, content.rating == 0 else { return }
        localService?.delete(content: content)
    }
}

extension ContentRaterUseCase: ContentRating {

    public func stopRatingContent() {
        self.content = nil
        self.otherRatings = []
        self.didFetchRating = false
    }

    public func setup(for content: AddictiveContent) {
        stopRatingContent()
        self.content = content

        self.setup = localService?
            .getContent(id: content.hostID)
            .map(\.rating)
            .sink { [weak self] _ in
                self?.didFetchRating = true
            } receiveValue: { [weak self] rating in
                self?.content?.rating = rating
            }
    }

    public func set(rating: Int) {
        guard let content = content else { return }
        self.content?.rating = rating
        self.localService?.save(rating: rating, content: content)
    }
}
