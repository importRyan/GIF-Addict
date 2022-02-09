//// Copyright 2022 Ryan Ferrell
//
//import SwiftUI
//
//// MARK: - API: View
//
//public extension View {
//    /// Applies a system-scaled custom font that adapts to a user's preference (e.g., for dyslexia or additional font scaling)
//    func adaptiveFont(_ config: Font.Config?) -> some View {
//        self.modifier(AdaptiveFontModifier(config))
//    }
//}
//
//public extension ScaledMetric {
//    /// Access dynamic type size of a Font preset, with conversion to the desired numeric type
//    init(_ config: Font.Config) {
//        self.init(wrappedValue: Value(config.size), relativeTo: config.anchor)
//    }
//}
//
//public extension Font {
//    /// Creates a non-system scaled custom font that adapts to a user's preference (e.g., for dyslexia or additional font scaling)
//    static func adaptiveFace(notScaled config: Font.Config?) -> Font? {
//        guard let config = config else { return nil }
//        return config.getFont(overrideFace: nil, scaledSize: config.size)
//    }
//}
//
//public extension EnvironmentValues {
//    /// User-selected font face that will override any `.adaptive` font styles
//    var fontFace: Font.Face? {
//        get { return self[FontFaceEVK.self] }
//        set { self[FontFaceEVK.self] = newValue }
//    }
//
//    /// User-selected font scaling beyond system scaling
//    var userFontScaling: CGFloat {
//        get { return self[UserFontScalingEVK.self] }
//        set { self[UserFontScalingEVK.self] = newValue }
//    }
//
//    /// Offset applied to a hierarchy to compensate for a user-selected font face
//    var baselineOffset: CGFloat {
//        get { return self[BaselineOffsetEVK.self] }
//        set { self[BaselineOffsetEVK.self] = newValue }
//    }
//}
//
//// MARK: - API: Configuration Builder
//
//public extension Font {
//
//    /// Constructs a scaling Font instance
//    struct Config {
//        public var face: Face
//        public var size: CGFloat
//        public var anchor: TextStyle
//        public var weight: Weight
//        public var design: Design
//        public var options: Set<Options>
//    }
//}
//
//public extension Font.Config {
//
//    /// Adjust font weight step-wise
//    func adjustingWeight(steps: Int) -> Self {
//        if steps == 0 { return self }
//        let nextWeight = weight.adjust(by: steps)
//        return withWeight(nextWeight)
//    }
//
//    /// Optionally increase weight one step
//    func bumpWeight(_ shouldBump: Bool) -> Self {
//        shouldBump ? adjustingWeight(steps: 1) : self
//    }
//
//    /// Optionally decrease weight one step
//    func dropWeight(_ shouldDrop: Bool) -> Self {
//        shouldDrop ? adjustingWeight(steps: -1) : self
//    }
//
//    /// Optionally set a new weight
//    func withWeight(_ adjusted: Font.Weight?) -> Self {
//        .init(face: face, size: size, anchor: anchor, weight: adjusted ?? weight, design: design, options: options)
//    }
//
//    /// Adjust size using its `anchor` `Font.TextStyle` and the Human Interface Guideline sizes as ladder steps, optionally changing its anchor to the new reference `Font.TextStyle`
//    func adjustingSize(steps: Int, changeAnchor: Bool = false) -> Self {
//        if steps == 0 { return self }
//        let nextPeg = anchor.adjust(by: steps)
//        let sizeDiffHIG = nextPeg.guidelineSize - anchor.guidelineSize
//        let nextSize = size + sizeDiffHIG
//        return .init(face: face,
//                     size: nextSize,
//                     relativeTo: changeAnchor ? nextPeg : anchor,
//                     weight: weight, design: design, options: options)
//    }
//
//    /// Manually increment or decrement font size, retaining the same anchor `Font.TextStyle`
//    func adjustingSize(points: CGFloat) -> Self {
//        .init(face: face, size: size + points, anchor: anchor, weight: weight, design: design, options: options)
//    }
//
//    /// Construct a configured Font instance
//    func getFont(overrideFace: Font.Face?, scaledSize: CGFloat) -> Font {
//        let _face = (overrideFace ?? face)
//        let hasItalics = _face._hasItalicVariant(weight, design)
//
//        var font = _face.font(
//            size: scaledSize,
//            weight: weight,
//            design: design,
//            italic: options.contains(.italic)
//        )
//        if options.contains(.monospacedDigit) { font = font.monospacedDigit() }
//        if options.contains(.smallCapsLowercase) { font = font.lowercaseSmallCaps() }
//        else if options.contains(.smallCapsUppercase) { font = font.uppercaseSmallCaps() }
//        else if options.contains(.smallCaps) { font = font.smallCaps() }
//        if options.contains(.italic) && !hasItalics { font = font.italic() }
//        return font
//    }
//
//    /// Offset to render a custom font face alongside the system font
//    func getBaselineOffset(overrideFace: Font.Face?, scaledSize: CGFloat) -> CGFloat {
//        (overrideFace ?? face).baselineOffset(pointSize: scaledSize)
//    }
//
//    /// Construct a custom user-adaptive font style
//    init(face: Font.Face = .system,
//         size: CGFloat,
//         relativeTo: Font.TextStyle,
//         weight: Font.Weight,
//         design: Font.Design = .default,
//         options: Set<Font.Options> = []
//    ) {
//        self.face = face
//        self.size = size
//        self.anchor = relativeTo
//        self.weight = weight
//        self.design = design
//        self.options = options
//    }
//
//    init(peg: Font.TextStyle,
//         weight: Font.Weight? = nil,
//         design: Font.Design = .default,
//         options: Set<Font.Options> = []) {
//        self.face = .system
//        self.size = peg.guidelineSize
//        self.anchor = peg
//        self.weight = weight ?? peg.guidelineWeight
//        self.design = design
//        self.options = options
//    }
//
//}
//
//// MARK: - API: Font Faces
//
//public extension Font {
//
//    /// This app's font faces
//    enum Face: String, Hashable, CaseIterable, Identifiable {
//        case system
//        case chalkboard
//        case openDyslexic
//    }
//}
//
//public extension Font.Face {
//
//    /// Display name for a font configuration
//    func name(_ weight: Font.Weight, _ design: Font.Design, italic: Bool) -> String {
//        _names(weight, design, italic).display
//    }
//
//    /// Construct a base Font representation
//    func font(size: CGFloat, weight: Font.Weight, design: Font.Design, italic: Bool) -> Font {
//        switch self {
//        case .system: return .system(size: size, weight: weight, design: design)
//        default:      return .custom(_names(weight, design, italic).resource, size: size)
//        }
//    }
//
//    /// Offset to render a custom font face alongside the system font
//    func baselineOffset(pointSize: CGFloat) -> CGFloat {
//        switch self {
//        case .system: return 0
//        case .chalkboard: return 0
//        case .openDyslexic: return 4
//        }
//    }
//
//    /// Does this font have italic faces?
//    func _hasItalicVariant(_ weight: Font.Weight, _ design: Font.Design) -> Bool {
//        switch self {
//        case .system: return true
//        default: return false
//        }
//    }
//
//    func _names(_ weight: Font.Weight, _ design: Font.Design, _ italic: Bool) -> (resource: String, display: String) {
//        switch self {
//        case .system: return ("", "System default")
//
//        case .chalkboard:
//            if design == .monospaced { return ("ChalkboardSE-Regular", "Chalkboard") }
//            switch weight {
//            case (.medium)...: return ("ChalkboardSE-Bold", "Chalkboard Bold")
//            case ...(.regular): return ("ChalkboardSE-Regular", "Chalkboard")
//            default: return ("", "")
//            }
//
//        case .openDyslexic:
//            if design == .monospaced { return ("OpenDyslexicMono-Regular", "OpenDyslexic 3 Monospaced") }
//            switch weight {
//            case (.medium)...: return ("OpenDyslexicThree-Bold", "OpenDyslexic 3 Bold")
//            case ...(.regular): return ("OpenDyslexicMono-Regular", "OpenDyslexic 3")
//            default: return ("", "")
//            }
//        }
//    }
//
//    var id: RawValue { rawValue }
//}
//
//// MARK: - API: Options
//
//public extension Font {
//
//    enum Options {
//        case monospacedDigit
//        case smallCapsUppercase
//        case smallCapsLowercase
//        case smallCaps
//        case italic
//    }
//}
//
//// MARK: - Implementation: ViewModifier
//
//fileprivate struct AdaptiveFontModifier: ViewModifier {
//
//    static let placeholder = Font.Config(face: .system, size: 1, anchor: .body, weight: .thin, design: .default, options: [])
//
//    init(_ config: Font.Config?) {
//        self.config = config
//        _scaledSize = .init(config ?? Self.placeholder)
//    }
//
//    @ScaledMetric private var scaledSize: CGFloat
//    @Environment(\.fontFace) private var face
//    @Environment(\.userFontScaling) private var userScaling
//    @Environment(\.baselineOffset) private var baselineOffset
//    private let config: Font.Config?
//
//    func body(content: Content) -> some View {
//        let size = scaledSize + userScaling
//        let offset = config?.getBaselineOffset(overrideFace: face, scaledSize: size)
//        return content
//            .alignmentGuide(.firstTextBaseline) { $0[.firstTextBaseline] + (offset ?? 0) }
//            .environment(\.baselineOffset, offset ?? baselineOffset)
//            .font(config?.getFont(overrideFace: face, scaledSize: size))
//    }
//}
//
//// MARK: - Support: Private EnviromentKeys
//
//private extension EnvironmentValues {
//
//    struct FontFaceEVK: EnvironmentKey {
//        static let defaultValue: Font.Face? = nil
//    }
//
//    struct UserFontScalingEVK: EnvironmentKey {
//        static let defaultValue: CGFloat = 0
//    }
//
//    struct BaselineOffsetEVK: EnvironmentKey {
//        static let defaultValue: CGFloat = 0
//    }
//}
//
//// MARK: - Support: Comparable+
//
//extension Font.Weight: Comparable, CaseIterable, Rankable {
//
//    public static func < (lhs: Font.Weight, rhs: Font.Weight) -> Bool {
//        lhs.css < rhs.css
//    }
//
//    public var css: Int {
//        switch self {
//        case .ultraLight: return 100
//        case .light: return 200
//        case .thin: return 300
//        case .regular: return 400
//        case .medium: return 500
//        case .semibold: return 600
//        case .bold: return 700
//        case .heavy: return 800
//        case .black: return 900
//        default:  return 400
//        }
//    }
//
//    var rank: Int { (css / 100) - 1 }
//    static var ranked: [Self] = Self.allCases
//    public static var allCases: [Font.Weight] = [
//        .ultraLight, .light, .thin, .regular, .medium, .semibold, .bold, .heavy, .black
//    ]
//}
//
//extension Font.TextStyle: Comparable {
//
//    public static func < (lhs: Font.TextStyle, rhs: Font.TextStyle) -> Bool {
//        lhs.guidelineSize < rhs.guidelineSize
//    }
//
//#if os(iOS)
//    /// Human Interface Guidelines
//    public var guidelineSize: CGFloat {
//        switch self {
//        case .largeTitle: return 34
//        case .title: return 28
//        case .title2: return 22
//        case .title3: return 20
//        case .headline: return 17
//        case .body: return 17
//        case .callout: return 16
//        case .subheadline: return 15
//        case .footnote: return 13
//        case .caption: return 12
//        case .caption2: return 11
//        @unknown default: fatalError()
//        }
//    }
//#elseif os(macOS)
//    /// Human Interface Guidelines
//    public var guidelineSize: CGFloat {
//        switch self {
//        case .largeTitle: return 32
//        case .title: return 22
//        case .title2: return 17
//        case .title3: return 15
//        case .headline: return 13
//        case .body: return 13
//        case .callout: return 12
//        case .subheadline: return 11
//        case .footnote: return 10
//        case .caption: return 10
//        case .caption2: return 10
//        @unknown default: fatalError()
//        }
//    }
//#endif
//
//#if os(iOS)
//    public var guidelineWeight: Font.Weight {
//        switch self {
//        case .headline: return .semibold
//        default: return .regular
//        }
//    }
//#elseif os(macOS)
//    public var guidelineWeight: Font.Weight {
//        switch self {
//        case .headline: return .bold
//        case .caption2: return .medium
//        default: return .regular
//        }
//    }
//#endif
//
//    static var allCases: [Font.TextStyle] = [
//        .largeTitle, .title, .title2, .title3, .headline, .body, .callout, .subheadline, .footnote, .caption, .caption2
//    ]
//}
//
//protocol Rankable {
//    /// **Zero-based** ascending rank order
//    var rank: Int { get }
//    static var ranked: [Self] { get }
//    func adjust(by steps: Int) -> Self
//}
//
//extension Rankable {
//    func adjust(by steps: Int) -> Self {
//        if steps == 0 { return self }
//        let currentAllCasesIndex = self.rank
//        let targetIndex = currentAllCasesIndex + steps
//
//        guard Self.ranked.indices.contains(targetIndex) else {
//            return steps < 0 ? Self.ranked.first! : Self.ranked.last!
//        }
//        return Self.ranked[targetIndex]
//    }
//}
//
//extension Font.TextStyle: Rankable {
//    var rank: Int {
//        switch self {
//        case .largeTitle: return 10
//        case .title: return 9
//        case .title2: return 8
//        case .title3: return 7
//        case .headline: return 6
//        case .body: return 5
//        case .callout: return 4
//        case .subheadline: return 3
//        case .footnote: return 2
//        case .caption: return 1
//        case .caption2: return 0
//        @unknown default: fatalError()
//        }
//    }
//
//    static var ranked: [Self] = { Self.allCases.sorted { $0.rank < $1.rank } }()
//}
//
