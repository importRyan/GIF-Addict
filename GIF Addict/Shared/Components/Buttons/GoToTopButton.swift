// Copyright 2022 Ryan Ferrell

import SwiftUI

struct GoToTopButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            SFSymbol.up.image()
        }
        .buttonStyle(.highlightScale(.accentColor, Local.scrollToTop.key))
            .padding(.vertical, 20)
    }
}
