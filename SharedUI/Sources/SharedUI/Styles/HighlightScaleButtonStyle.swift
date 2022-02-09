// Copyright 2022 Ryan Ferrell

import SwiftUI

public extension ButtonStyle where Self == HighlightScaleButtonStyle {

    static func highlightScale(_ foreground: Color?, _ subtitle: LocalizedStringKey?) -> Self {
        .init(foreground: foreground, subtitle: subtitle)
    }

    static var highlightScale: Self { Self() }
}

public struct HighlightScaleButtonStyle: ButtonStyle {

    public init(foreground: Color? = nil, subtitle: LocalizedStringKey? = nil) {
        self.foreground = foreground
        self.subtitle = subtitle
    }

    var foreground: Color?
    var subtitle: LocalizedStringKey?

    public func makeBody(configuration: Configuration) -> some View {
        StyledButton(config: configuration, style: self)
    }

    private struct StyledButton: View {

        var config: Configuration
        var style: HighlightScaleButtonStyle

        @State private var isHovered = false

        var body: some View {
            VStack(alignment: .center, spacing: 15) {
                config.label
                    .scaleEffect(config.isPressed ? 0.9 : 1)
                    .opacity(config.isPressed ? 0.9 : 1)

                if style.subtitle != nil { subtitle }
            }
            .contentShape(Rectangle())
            .foregroundColor(isHovered ?.accentColor : style.foreground)
            .animate(colorEffect, isHovered)
            .animate(motionEffect, config.isPressed)
            .onHover { isHovered = $0 }
        }

        private var subtitle: some View {
            Text(style.subtitle!)
                .font(.fira(size: 16, weight: .medium, style: .headline))
                .foregroundColor(.addictPurple1)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .truncationMode(.tail)
                .padding(.vertical, 5)
                .padding(.horizontal, 12)
                .background(Color.accentColor,
                            in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .offset(y: isHovered ? 0 : 6)
                .compositingGroup()
                .scaleEffect(isHovered ? 1 : 0.8, anchor: .bottom)
                .opacity(isHovered ? 1 : 0)
                .animate(subtitleEffect, isHovered)
        }

        private var colorEffect: Animation { .easeOut(duration: .fast) }
        private var motionEffect: Animation { .spring() }
        private var subtitleEffect: Animation { .easeOut(duration: .medium) }
    }
}
