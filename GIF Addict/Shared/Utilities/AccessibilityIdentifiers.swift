// Copyright 2022 Ryan Ferrell

import SwiftUI

extension View {
    func test(id: AccessibilityIdentifier) -> some View {
        accessibilityIdentifier(id.rawValue)
    }
}

enum AccessibilityIdentifier: String {
    case priorQueryHistoryItem
    case searchIcon
    case searchTextField
    case searchBackground
    case searchPrompt
    case clearButton
    case favoritesButton
    case sharePlayButton
    case sortButton
    case searchResultPreviewGIF
    case searchResultsCount
}
