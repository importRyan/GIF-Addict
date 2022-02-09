// Copyright 2022 Ryan Ferrell

import Addiction
import AddictiveServices
import SwiftUI

struct FocusedContentView: View, LazyImageViewHost {

    let urlProcessor: URLProcessor.Type
    let content: AddictiveContent
    let rateAction: (Int) -> Void

    @Environment(\.openURL) private var openURL
    @State private var isHovering = false

    @Environment(\.namespace) private var namespace
    @Namespace private var backupNamespace

    var body: some View {
        VStack(alignment: .center, spacing: 0) {

            Spacer(minLength: 35)

            StarRatingControl(currentRating: content.rating, rateAction: rateAction)
                .font(.largeTitle)
                .zIndex(5)

            Spacer(minLength: 25).frame(maxHeight: 45)

            lazyOriginalImage
                .matchedGeometryEffect(id: content.hostID + content.host, in: namespace ?? backupNamespace)
                .aspectRatio(content.representations.originalSize, contentMode: .fit)
                .overlay(overlay.animate(.easeOut, isHovering), alignment: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onHover { isHovering = $0 }
                .frame(maxWidth: 500, maxHeight: 500)
                .onTapGesture(perform: openSource)

            Spacer(minLength: 25)
        }
    }

    @ViewBuilder private var overlay: some View {
        if isHovering { Overlay(vm: .init(content: content), open: openSource) }
    }

    private func openSource() {
        guard let url = urlProcessor.init(url: content.sourceURL).getURL() else { return }
        openURL(url) { isHovering = !$0 }
    }
}
