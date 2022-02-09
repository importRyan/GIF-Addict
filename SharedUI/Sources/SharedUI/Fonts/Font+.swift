// Copyright 2022 Ryan Ferrell

import SwiftUI

public extension Font {

    static let GilbertColorFontName = "Gilbert Color"

    static func gilbert(size: CGFloat) -> Font {
        .custom(GilbertColorFontName, size: size)
    }

    static func fira(size: CGFloat,
                     weight: Weight,
                     style: TextStyle,
                     italic: Bool = false
    ) -> Font {
        .custom(Fira(weight: weight, isItalic: italic).rawValue, size: size, relativeTo: style)
    }

    /// Must be called to use SPM residing fonts
    static func registerPackageFonts() {
        Fira.allCases.map(\.rawValue).forEach(registerFont)
    }
}

public enum Fira: String, CaseIterable {

    case black = "FiraSans-Black"
    case heavy = "FiraSans-ExtraBold"
    case bold = "FiraSans-Bold"
    case semibold = "FiraSans-SemiBold"
    case medium = "FiraSans-Medium"
    case regular = "FiraSans-Regular"
    case thin = "FiraSans-Thin"
    case light = "FiraSans-Light"
    case extraLight = "FiraSans-ExtraLight"

    case blackItalic = "FiraSans-BlackItalic"
    case heavyItalic = "FiraSans-ExtraBoldItalic"
    case boldItalic = "FiraSans-BoldItalic"
    case semiboldItalic = "FiraSans-SemiBoldItalic"
    case mediumItalic = "FiraSans-MediumItalic"
    case regularItalic = "FiraSans-Italic"
    case thinItalic = "FiraSans-ThinItalic"
    case lightItalic = "FiraSans-LightItalic"
    case extraLightItalic = "FiraSans-ExtraLightItalic"

    public var weight: Font.Weight {
        switch self {
        case .black, .blackItalic: return .black
        case .heavy, .heavyItalic: return .heavy
        case .bold, .boldItalic: return .bold
        case .medium, .mediumItalic: return .medium
        case .semibold, .semiboldItalic: return .semibold
        case .regular, .regularItalic: return .regular
        case .thin, .thinItalic: return .thin
        case .light, .lightItalic: return .light
        case .extraLight, .extraLightItalic: return .ultraLight
        }
    }

    public var isItalic: Bool { rawValue.hasSuffix("Italic") }

    public init(weight: Font.Weight, isItalic: Bool) {
        switch weight {
        case .black: self = isItalic ? .blackItalic : .black
        case .heavy: self = isItalic ? .heavyItalic : .heavy
        case .bold: self = isItalic ? .boldItalic : .bold
        case .medium: self = isItalic ? .mediumItalic : .medium
        case .semibold: self = isItalic ? .semiboldItalic : .semibold
        case .regular: self = isItalic ? .regularItalic : .regular
        case .thin: self = isItalic ? .thinItalic : .thin
        case .light: self = isItalic ? .lightItalic : .light
        case .ultraLight: self = isItalic ? .extraLightItalic : .extraLight
        default: self = .regular
        }
    }
}

private func registerFont(name: String) {

    guard let fontURL = Bundle.module.url(forResource: name, withExtension: "ttf"),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
              fatalError("Couldn't create font from data")
          }

    var error: Unmanaged<CFError>?

    CTFontManagerRegisterGraphicsFont(font, &error)
}
