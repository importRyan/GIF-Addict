// Copyright 2022 Ryan Ferrell

import Addiction
import SwiftUI

extension FocusedContentView {

    struct Overlay: View {

        let vm: ContentOverlayVM
        let open: () -> Void

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {

                Text(vm.title)
                    .font(.fira(size: 25, weight: .regular, style: .body))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)

                if let label = vm.sourceLabel {
                    Button(label, action: open)
                        .buttonStyle(.borderless)
                }

                dates
            }
            .colorScheme(.dark)
            .font(.fira(size: 16, weight: .regular, style: .body))
            .padding(.top, 100)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 175, alignment: .bottom)
            .background(fade)
        }

        private var dates: some View {
            HStack(alignment: .firstTextBaseline, spacing: 30) {
                if vm.showDateCreated {
                    LabeledStringStat(label: vm.dateCreatedLabel, stat: vm.dateCreated)
                }
                if vm.showDateTrending {
                    LabeledStringStat(label: vm.dateTrendingLabel, stat: vm.dateTrendingLabel)
                }
            }
        }

        private var fade: some View {
            LinearGradient(
                stops: [
                    .init(color: .black.opacity(0), location: 0),
                    .init(color: .black.opacity(0.85), location: 0.4)
                ],
                startPoint: .top,
                endPoint: .bottom)
        }
    }
}
