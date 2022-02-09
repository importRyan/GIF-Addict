// Copyright 2022 Ryan Ferrell

import SwiftUI

struct SortButton: View {

    var isAscending: Bool
    let didTap: () -> Void

    @State private var isHovering = false

    var body: some View {
        Button(action: didTap, label: {
            HStack {
                SFSymbol.sort.image()
                    .rotation3DEffect(isAscending ? .zero : .degrees(180), axis: (x: 1, y: 0, z: 0))
                    .font(.fira(size: 15, weight: .medium, style: .footnote))

                Text(Local.byRating.key)
                    .textCase(.lowercase)
                    .foregroundColor(.secondary)
                    .opacity(isHovering ? 1 : 0)
            }
        })
            .test(id: .sortButton)
            .buttonStyle(.highlightScale)
            .animate(.linear, isHovering)
            .animate(.linear, isAscending)
            .onHover { isHovering = $0 }
    }
}
