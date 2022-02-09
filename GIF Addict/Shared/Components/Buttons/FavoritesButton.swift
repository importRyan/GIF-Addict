// Copyright 2022 Ryan Ferrell

import SharedUI
import SwiftUI

struct FavoritesButton: View {

    let action: () -> Void
    let isOn: Bool

    var body: some View {
        Button(action: action, label: {
                SFSymbol.star.image()
                .symbolVariant(isOn ? .fill : .none)
                .scaleEffect(isOn ? 1.25 : 1)
            }
        )
            .buttonStyle(.highlightScale(isOn ? .accentColor : .addictPurple7, Local.favorites.key))
            .font(.fira(size: 25, weight: .medium, style: .largeTitle))
            .test(id: .favoritesButton)
    }
}
