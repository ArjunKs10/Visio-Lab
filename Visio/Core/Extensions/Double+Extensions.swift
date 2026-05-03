import Foundation

/// Double extensions — angle conversions (deg↔rad) and rounding helpers
extension Double {

    // MARK: - Angle Conversions

    /// Convert degrees to radians
    var toRadians: Double {
        self * .pi / 180.0
    }

    /// Convert radians to degrees
    var toDegrees: Double {
        self * 180.0 / .pi
    }

    // MARK: - Rounding

    /// Round to a specific number of decimal places
    /// - Parameter places: number of decimal places
    /// - Returns: rounded value
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    // MARK: - Formatting

    /// Format as a string with a given number of decimal places
    /// - Parameter places: number of decimal places (default 2)
    /// - Returns: formatted string
    func formatted(decimals: Int = 2) -> String {
        String(format: "%.\(decimals)f", self)
    }

    /// Format as a degree string (e.g. "45.0°")
    var degreeString: String {
        "\(self.rounded(to: 1).formatted(decimals: 1))°"
    }

    /// Format as a radian string (e.g. "0.79 rad")
    var radianString: String {
        "\(self.rounded(to: 2).formatted(decimals: 2)) rad"
    }

    // MARK: - Angle Normalization

    /// Normalize angle to [0, 2π)
    var normalizedAngle: Double {
        let twoPi = 2 * Double.pi
        var result = self.truncatingRemainder(dividingBy: twoPi)
        if result < 0 { result += twoPi }
        return result
    }

    /// Normalize angle to [0, 360)
    var normalizedDegrees: Double {
        var result = self.truncatingRemainder(dividingBy: 360)
        if result < 0 { result += 360 }
        return result
    }

    // MARK: - Clamping

    /// Clamp value to a closed range
    func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
