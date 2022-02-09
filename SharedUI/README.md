# SharedUI

SwiftUI components and environment utilities for general use.

@Environment(\.accessibilityReduceMotion) is wrapped into a @Environment(\.animationSpeed) state that allows for user customization and UI testing acceleration on macOS.

@Environment(\.fontFace), (\.sizeAdjustment), and (\.baselineOffset) allow custom font face switching (e.g., for dyslexia) under DynamicType
