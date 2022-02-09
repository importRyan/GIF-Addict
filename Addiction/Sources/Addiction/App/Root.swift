import Foundation

public class Root: ObservableObject {

    internal var services: ServicesContainer!

    public init() {}
}

public extension Root {

    /// Lazily load services after main thread established.
    ///
    func load(services: ServicesContainer) {
        self.services = services
    }

    /// Create vendor for UI state objects
    ///
    func makeSceneUseCaseFactory() -> UseCaseFactory {
        UseCaseFactory(services)
    }
}
