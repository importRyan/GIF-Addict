// Copyright 2022 Ryan Ferrell

import SwiftUI

enum SFSymbol: String {
    case sharePlay = "shareplay"
    case search = "magnifyingglass"
    case history = "clock"
    case sort = "arrow.up.arrow.down"
    case star = "heart"
    case cancel = "xmark"
    case up = "arrow.up"

    func image() -> Image {
        Image(systemName: rawValue)
    }
}
