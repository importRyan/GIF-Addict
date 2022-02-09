// Copyright 2022 Ryan Ferrell

import SharedUI
import SwiftUI

struct ClearButton: View {

    let action: () -> Void
    let isHidden: Bool

    var body: some View {
        Button(
            action: action,
            label: {
                SFSymbol.cancel.image()
                    .symbolVariant(.circle)
                    .symbolVariant(.fill)
            }
        )
            .buttonStyle(.highlightScale(.addictPurple7, nil))
            .font(.fira(size: 25, weight: .medium, style: .largeTitle))
            .opacity(isHidden ? 0 : 1)
            .animate(.easeOut(duration: .medium), isHidden)
            .test(id: .clearButton)
    }
}
