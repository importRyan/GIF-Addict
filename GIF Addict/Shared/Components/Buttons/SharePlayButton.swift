// Copyright 2022 Ryan Ferrell

import SharedUI
import SwiftUI

struct SharePlayButton: View {

    let vm: SharePlayButtonVM

    @State private var showTip = false

    var body: some View {
        Button(
            action: tapped,
            label: { vm.image.image() }
        )
            .buttonStyle(.highlightScale(vm.isActive ? .blue : .addictPurple7, vm.buttonLabel))
            .font(.fira(size: 25, weight: .medium, style: .largeTitle))
            .test(id: .sharePlayButton)
            .popover(isPresented: $showTip) {

                VStack(alignment: .leading, spacing: 10) {
                    Text("Share GIFs with Friends")
                        .font(.headline)
                        .padding(.bottom)

                    LabeledStringStat(label: "1", stat: "Start a FaceTime call.")
                    LabeledStringStat(label: "2", stat: "Tap me again.")
                    LabeledStringStat(label: "3", stat: "Your friend(s) will see your next search and selections.")
                    LabeledStringStat(label: "Tip", stat: "Screen sharing can cancel SharePlay sessions.")
                }
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding()
            }
    }

    private func tapped() {
        if vm.isReadyToStartNewSession {
            vm.didTap()
        } else {
            showTip = true
        }
    }
}
