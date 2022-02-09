// Copyright 2022 Ryan Ferrell

import Addiction
import AddictiveServices
import SwiftUI

struct FocusedContentScreen<Rater: ContentRating>: View {

    @ObservedObject var rater: Rater

    var body: some View {
        if let content = rater.content {
            ZStack {
                Cancel(action: cancel, label: Color.addictPurple1.opacity(0.5))

                FocusedContentView(urlProcessor: DefaultURLProcessor.self, content: content, rateAction: rater.set(rating:))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(escapingMaterial)
                .padding(50)
            }
            .transition(.scale.combined(with: .opacity))
        }
    }

    @Environment(\.colorScheme) private var scheme
    private var escapingMaterial: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(scheme == .dark ? .regularMaterial : .ultraThinMaterial)
            .onTapGesture(perform: cancel)
    }

    private func cancel() {
        let transaction = Transaction(animation: .spring().speed(2))
        withTransaction(transaction) {
            rater.stopRatingContent()
        }
    }

    struct Cancel<Label: View>: View {
        var action: () -> Void
        let label: Label
        var body: some View {
            Button(action: action, label: { label })
                .buttonStyle(.plain)
                .keyboardShortcut(.cancelAction)
        }
    }
}
