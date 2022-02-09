// Copyright 2022 Ryan Ferrell

import Addiction
import NukeUI
import SharedUI
import SwiftUI

extension NukeUI.ImagePipeline {
   static func setup() {
        ImagePipeline.Configuration.isSignpostLoggingEnabled = false
        ImagePipeline.shared = ImagePipeline(configuration: .withDataCache)
    }
}

/// Wraps Addiction model into NukeUI components
///
protocol LazyImageViewHost: View {
    var content: AddictiveContent { get }
}

// MARK: - Base implementation

extension LazyImageViewHost {

    var lazyPreviewImage: some View {
        LazyImage(source: content.representations.previewURL, content: render(state:))
    }

    var lazyOriginalImage: some View {
        LazyImage(source: content.representations.originalURL, content: render(state:))
    }

    /// Gray background
    var blankPlaceholder: some View {
        RoundedRectangle(cornerRadius: 10).fill(Color.addictPurple2)
    }
}

extension LazyImageViewHost {

    @ViewBuilder func render(state: LazyImageState) -> some View {
        if let image = state.image {
            image

        } else if let error = state.error {
            Text("Error \(error.localizedDescription)")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .foregroundColor(.red)

        } else {
            blankPlaceholder
        }
    }
}
