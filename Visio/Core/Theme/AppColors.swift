import SwiftUI

/// All color constants as static Color properties
/// Math accent:    #5E7CE2 (blue-indigo)
/// Physics accent: #3DBFA8 (teal-green)
struct AppColors {

    // MARK: - Primary Accents

    /// Blue-indigo accent for Math modules
    static let mathAccent = Color(hex: "5E7CE2")

    /// Teal-green accent for Physics modules
    static let physicsAccent = Color(hex: "3DBFA8")

    // MARK: - Backgrounds

    /// Primary background — adapts to dark/light mode automatically
    static let background = Color(.systemBackground)

    /// Secondary background for canvas areas, cards, and grouped content
    static let secondaryBackground = Color(.secondarySystemBackground)

    /// Tertiary background for nested grouped content
    static let tertiaryBackground = Color(.tertiarySystemBackground)

    // MARK: - Labels

    /// Primary label color — adapts automatically
    static let label = Color(.label)

    /// Secondary label color — for descriptions, captions
    static let secondaryLabel = Color(.secondaryLabel)

    /// Tertiary label color — for subtle hints
    static let tertiaryLabel = Color(.tertiaryLabel)

    // MARK: - Semantic Colors

    /// Positive values (e.g. positive sin, upward velocity)
    static let positive = Color(hex: "34C759")

    /// Negative values (e.g. negative cos, downward velocity)
    static let negative = Color(hex: "FF3B30")

    /// Zero / neutral values
    static let neutral = Color(.systemGray)

    /// Warning / undefined state (e.g. tan undefined)
    static let warning = Color(hex: "FF9500")

    // MARK: - Unit Circle Specific

    /// Sin projection line color (vertical / green)
    static let sinColor = Color(hex: "34C759")

    /// Cos projection line color (horizontal / red-orange)
    static let cosColor = Color(hex: "FF6B6B")

    /// Tan indicator color
    static let tanColor = Color(hex: "FF9500")

    // MARK: - Projectile Specific

    /// Horizontal velocity vector (Vx)
    static let velocityX = Color(hex: "FF3B30")

    /// Vertical velocity vector (Vy)
    static let velocityY = Color(hex: "34C759")

    /// Sky gradient top (light blue) — only gradient allowed in the entire app
    static let skyTop = Color(hex: "B8D4E3")

    /// Sky gradient bottom (fades to system background)
    static let skyBottom = Color(hex: "E8F0F5")

    /// Ground / grass tint
    static let ground = Color(hex: "7CB342")

    // MARK: - Grid Colors

    /// Minor grid lines
    static let gridMinor = Color(.systemGray5)

    /// Major grid lines
    static let gridMajor = Color(.systemGray3)

    /// Axis lines (bold)
    static let gridAxis = Color(.label)

    /// Grid numeric labels
    static let gridLabel = Color(.secondaryLabel)

    // MARK: - Quadrant Highlight Colors

    /// Active quadrant highlight background
    static let quadrantActive = Color(hex: "5E7CE2").opacity(0.2)

    /// Inactive quadrant background
    static let quadrantInactive = Color(.systemGray5)

    // MARK: - Wave Interference Specific

    /// Constructive interference zone tint
    static let constructive = Color(hex: "5E7CE2").opacity(0.3)

    /// Destructive interference zone tint (warm complement)
    static let destructive = Color(hex: "E27C5E").opacity(0.3)

    // MARK: - Category Tag Colors

    /// Math category pill background
    static let mathTagBackground = Color(hex: "5E7CE2").opacity(0.12)

    /// Physics category pill background
    static let physicsTagBackground = Color(hex: "3DBFA8").opacity(0.12)

    // MARK: - Reference / Ghost

    /// Reference curve (gray, translucent)
    static let referenceCurve = Color.gray.opacity(0.35)

    /// Ghost trail for SHM (fading positions)
    static let ghostTrail = Color(.systemGray2)
}
