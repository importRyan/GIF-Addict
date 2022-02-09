// Copyright 2022 Ryan Ferrell

import SharedUI
import SwiftUI

struct SearchButton: View {

    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: { SFSymbol.search.image() }
        )
            .buttonStyle(.highlightScale(.addictPurple7, nil))
            .font(.fira(size: 25, weight: .medium, style: .largeTitle))
            .test(id: .searchIcon)
    }
}
