import Addiction
import SharedUI
import SwiftUI

struct ContentGridCell: View, LazyImageViewHost {

    @Environment(\.focusedContent) private var focus
    var content: AddictiveContent

    @Environment(\.namespace) private var namespace
    @Namespace private var backupNamespace

    var body: some View {
        image
            .onTapGesture { focus?.wrappedValue = content }
    }

    private var image: some View {
        ZStack {
            // Investigate: SDWebImage, Kingfisher
            // 24 tiles: 80% 100 MB with default NukeUI settings
            // Native AVPlayer and AsyncImage irrelevant
            if focus?.wrappedValue?.hostID != content.hostID {
                lazyPreviewImage
                    .matchedGeometryEffect(id: content.hostID + content.host, in: namespace ?? backupNamespace)
                    .aspectRatio(content.representations.originalSize, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(.square(250))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
