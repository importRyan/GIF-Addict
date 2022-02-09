import Foundation

public class UseCaseFactory: ObservableObject {

    private unowned let services: ServicesContainer

    internal init(_ services: ServicesContainer) {
        self.services = services
    }
}

extension UseCaseFactory {
    
    public typealias Session = SessionCoordinator<QueryComposer, ContentBrowserUseCase, ContentRaterUseCase>

    public func createBrowsingSession() -> Session {
        let (query, browser, rater) = createUniversalChildUseCases()
        var session: Session

        if #available(macOS 12, iOS 15, *) {
            session = GroupSessionController(query, browser, rater, services.local, services.remote)
        } else {
            session = SessionCoordinator(query, browser, rater, services.local, services.remote)
        }

        query.coordinator = session
        return session
    }
}

private extension UseCaseFactory {

    func createUniversalChildUseCases() -> (query: QueryComposer, browser: ContentBrowserUseCase, rater: ContentRaterUseCase) {

        let rater = ContentRaterUseCase(localService: services.local)
        let browser = ContentBrowserUseCase(content: services.remote, localService: services.local)
        let query = QueryComposer(
            coordinator: nil,
            languages: services.remote.supportedLanguageCodes
        )
        return (query, browser, rater)
    }
}
