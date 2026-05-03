import SwiftUI

/// Color extensions — hex init and adaptive color helpers
extension Color {

    /// Initialize a Color from a hex string (6 or 8 characters, with or without #)
    /// - Parameter hex: Hex string like "5E7CE2", "#5E7CE2", or "FF5E7CE2" (with alpha)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// Returns a color for a sign-based value:
    /// positive → green, negative → red, zero → gray
    static func forSign(_ value: Double) -> Color {
        if abs(value) < 0.001 {
            return AppColors.neutral
        }
        return value > 0 ? AppColors.positive : AppColors.negative
    }

    /// Returns a hue-cycled color for Fourier harmonics
    /// - Parameter index: harmonic index (1-based)
    /// - Parameter total: total number of harmonics for hue distribution
    static func harmonicColor(index: Int, total: Int = 15) -> Color {
        let hue = Double(index) / Double(max(total, 1))
        return Color(hue: hue, saturation: 0.7, brightness: 0.85)
    }
}
