import SwiftUI

/// Typography scale using SF Rounded
/// All labels and headings in Visio use SF Rounded for a friendly, approachable feel.
struct AppFonts {

    // MARK: - Dynamic Type Scale (SF Rounded)

    /// Large title — NavigationStack titles
    static let largeTitle = Font.system(.largeTitle, design: .rounded)

    /// Title 1 — module screen titles
    static let title = Font.system(.title, design: .rounded)

    /// Title 2 — section headers
    static let title2 = Font.system(.title2, design: .rounded)

    /// Title 3 — card titles, sub-section headers
    static let title3 = Font.system(.title3, design: .rounded)

    /// Headline — TopicCard names, bold labels
    static let headline = Font.system(.headline, design: .rounded)

    /// Subheadline — secondary descriptive text
    static let subheadline = Font.system(.subheadline, design: .rounded)

    /// Body — default readable text
    static let body = Font.system(.body, design: .rounded)

    /// Callout — slider labels, control panel text
    static let callout = Font.system(.callout, design: .rounded)

    /// Footnote — min/max slider labels
    static let footnote = Font.system(.footnote, design: .rounded)

    /// Caption — smallest text, grid labels, value units
    static let caption = Font.system(.caption, design: .rounded)

    /// Caption 2 — micro labels
    static let caption2 = Font.system(.caption2, design: .rounded)

    // MARK: - Weighted Variants

    /// Bold headline
    static let headlineBold = Font.system(.headline, design: .rounded).weight(.bold)

    /// Semibold callout for slider value readouts
    static let calloutSemibold = Font.system(.callout, design: .rounded).weight(.semibold)

    /// Semibold body for value badges
    static let bodySemibold = Font.system(.body, design: .rounded).weight(.semibold)

    /// Bold title3 for section card headers
    static let title3Bold = Font.system(.title3, design: .rounded).weight(.bold)

    // MARK: - Monospaced (for equations)

    /// Monospaced body for equation labels (e.g. y = 2·sin(0.5x + 0.79) + 1)
    static let equation = Font.system(.body, design: .monospaced)

    /// Monospaced callout for smaller equation / formula readouts
    static let equationSmall = Font.system(.callout, design: .monospaced)

    // MARK: - Convenience

    /// Returns a rounded font at a specific size and weight
    static func rounded(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.system(size: size, weight: weight, design: .rounded)
    }

    /// Returns a rounded font for a given text style
    static func rounded(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        Font.system(style, design: .rounded).weight(weight)
    }
}
