// Copyright 2022 Ryan Ferrell

import SwiftUI

// MARK: - Constants

extension CGFloat {
    static let standardPreviewItemSize: CGFloat = 325
    static let standardPreviewItemSpacing: CGFloat = 5

}

// MARK: - Conveniences

extension View {

    func frame(_ size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    func minFrame(content: CGSize, bounds: CGSize) -> some View {
        let width = min(content.width, bounds.width)
        let height = min(content.height, bounds.height)
        return self.frame(width: width, height: height, alignment: .center)
    }
}

extension CGSize {
    static func square(_ size: CGFloat) -> CGSize {
        .init(width: size, height: size)
    }
}
