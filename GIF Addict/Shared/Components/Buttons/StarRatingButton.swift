// Copyright 2022 Ryan Ferrell

import SwiftUI

struct StarRating: View {

    let action: () -> Void
    let isFilled: Bool

    var body: some View {
        Button(action: action, label: {
            SFSymbol.star.image()
                .symbolVariant(isFilled ? .fill : .none)
        })
    }
}
