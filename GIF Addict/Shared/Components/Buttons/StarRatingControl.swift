// Copyright 2022 Ryan Ferrell

import SwiftUI

struct StarRatingControl: View {

    let currentRating: Int
    let rateAction: (Int) -> Void

    @State private var hoverIndex: Int?

    var body: some View {
        HStack(alignment: .center) {

            ClearButton(action: { rateAction(0) }, isHidden: currentRating == 0 || hoverIndex == nil)
                .onHover { registerHoverEvent(at: 0, $0) }
                .padding(.trailing, 15)

            ForEach(1..<6) { index in
                StarRating(
                    action: { rateAction(index) },
                    isFilled: isFilled(at: index)
                )
                    .buttonStyle(.highlightScale(.accentColor.opacity(0.8), nil))
                    .onHover { registerHoverEvent(at: index, $0) }
            }

            // For center alignment
            ClearButton(action: { }, isHidden: true)
                .hidden()
                .accessibilityHidden(true)
                .padding(.leading, 15)
        }
        .contentShape(Rectangle())
        .onHover(perform: removeHoverOnExit(_:))
    }

    private func isFilled(at index: Int) -> Bool {
        guard let hoverIndex = hoverIndex else {
            return currentRating >= index
        }
        return hoverIndex >= index
    }

    private func registerHoverEvent(at index: Int, _ isHovering: Bool) {
        if isHovering { hoverIndex = index }
    }

    private func removeHoverOnExit(_ isHovering: Bool) {
        if !isHovering { hoverIndex = nil }
    }
}
