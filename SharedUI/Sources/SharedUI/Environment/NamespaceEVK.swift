@_exported import SwiftUI

private struct NamespaceEVK: EnvironmentKey {
    public static let defaultValue: Namespace.ID? = nil
}

public extension EnvironmentValues {

    /// Parent animation unique ID space.
    var namespace: Namespace.ID? {
        get { return self[NamespaceEVK.self] }
        set { self[NamespaceEVK.self] = newValue }
    }
}
