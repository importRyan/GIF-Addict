// Copyright 2022 Ryan Ferrell

import SwiftUI

public extension Double {

    static let fast = Double(0.15)
    static let medium = Double(0.3)
}

public extension View {

    /// Apply an animation that obeys UI test and user accessibility preferences
    func animate<E: Equatable>(_ animation: Animation, _ value: E) -> some View {
        modifier(AnimationEnvironmentModifier(animation: animation, value: value))
    }

    /// Adjust animation speed according to (foremost) a user's accessibilityReduceMotion option  and (secondarily) app preferences or launch environment
    func setupAnimationEnvironment(preference: AnimationSpeedEVK.Multiplier? = nil) -> some View {
        modifier(SetupAnimationEnvironmentModifier(appPreference: preference))
    }
}

public struct AnimationSpeedEVK: EnvironmentKey {
    public static let defaultValue = Multiplier.normal

    public enum Multiplier: Double {
        case normal = 1
        /// Apple: avoid large animations, especially those that simulate the third dimension
        case eliminate = 0
        /// XCUITest
        case fast = 3
        /// Bug diagnosis
        case slow = 0.2

        public var multiplier: Double { rawValue }

        /// "MOTION" key in ProcessInfo.processInfo.environment
        public init(processInfoEnvironmentMOTION: String?) {
            switch processInfoEnvironmentMOTION {
            case nil, "NORMAL": self = .normal
            case "ELIMINATE": self = .eliminate
            case "FAST": self = .fast
            case "SLOW": self = .slow
            default: self = .normal; NSLog("Unexpected motion environment value")
            }
        }
    }
}

public extension EnvironmentValues {
    /// Adjust animation speed according to (foremost) a user's accessibilityReduceMotion option  and (secondarily) app preferences or launch environment
    var animationSpeed: AnimationSpeedEVK.Value {
        get { return self[AnimationSpeedEVK.self] }
        set { self[AnimationSpeedEVK.self] = newValue }
    }
}

private struct AnimationEnvironmentModifier<Value: Equatable>: ViewModifier {

    var animation: Animation?
    var value: Value
    func body(content: Content) -> some View {
        Modified(content: content, animation: animation, value: value)
    }

    private struct Modified: View {
        let content: Content
        let animation: Animation?
        let value: Value
        @Environment(\.animationSpeed) private var speed
        var body: some View {
            content
                .animation(animation?.speed(speed.multiplier), value: value)
        }
    }
}

/// Transforms environment to set animation preferences for UI testing or user accessibility preferences.
private struct SetupAnimationEnvironmentModifier: ViewModifier {

    var appPreference: AnimationSpeedEVK.Multiplier?

    func body(content: Content) -> some View {
        Modified(content: content, appPreference: appPreference)
    }

    private struct Modified: View {
        let content: Content
        let appPreference: AnimationSpeedEVK.Multiplier?
        @Environment(\.animationSpeed) private var speed
        @Environment(\.accessibilityReduceMotion) private var appleReduceMotion
        var body: some View {
            content
                .transformEnvironment(\.animationSpeed) { value in
                    // Obey user preferences
                    if appleReduceMotion { value = .eliminate; return }
                    if let preference = appPreference, value != preference { value = preference; return }
                    // Fallback to launch environment (e.g., XCUITest)
                    let environment = ProcessInfo.processInfo.environment["MOTION"]
                    let environmentValue = AnimationSpeedEVK.Multiplier(processInfoEnvironmentMOTION: environment)
                    if value != environmentValue { value = environmentValue }
                }
        }
    }
}
