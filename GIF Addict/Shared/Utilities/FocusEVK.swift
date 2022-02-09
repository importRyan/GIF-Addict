// Copyright 2022 Ryan Ferrell

import Addiction
import SwiftUI

public extension EnvironmentValues {
    var focusedContent: FocusedContentEVK.Value {
        get { return self[FocusedContentEVK.self] }
        set { self[FocusedContentEVK.self] = newValue }
    }
}

public struct FocusedContentEVK: EnvironmentKey {
    public static let defaultValue: Binding<AddictiveContent?>? = nil
}
