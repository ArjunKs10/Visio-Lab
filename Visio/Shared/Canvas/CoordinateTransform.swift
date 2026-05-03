import Foundation

/// Shared math utility for converting between math space and screen space.
/// No MVC layer — pure coordinate transformation.
///
/// Math space: standard Cartesian (Y up, X right)
/// Screen space: UIKit/SwiftUI (Y down, X right)
///
/// The `origin` is the screen-space point where math (0,0) lives.
/// The `scale` is how many screen pixels equal 1 math unit.
struct CoordinateTransform {

    /// Screen point that corresponds to (0,0) in math space
    let origin: CGPoint

    /// Screen pixels per 1 math unit
    let scale: CGFloat

    // MARK: - Coordinate Conversion

    /// Convert a math-space point to screen-space point.
    /// - Y is flipped: positive math-Y goes upward on screen.
    func toScreen(_ point: CGPoint) -> CGPoint {
        CGPoint(
            x: origin.x + point.x * scale,
            y: origin.y - point.y * scale
        )
    }

    /// Convert a screen-space point to math-space point.
    /// - Inverse of toScreen.
    func toMath(_ point: CGPoint) -> CGPoint {
        CGPoint(
            x: (point.x - origin.x) / scale,
            y: (origin.y - point.y) / scale
        )
    }

    // MARK: - Length Scaling

    /// Scale a math-space length to screen pixels.
    /// Always returns a positive value.
    func scaleLength(_ mathLength: Double) -> CGFloat {
        abs(CGFloat(mathLength) * scale)
    }

    // MARK: - Zoom

    /// Return a new transform with adjusted scale (for pinch-to-zoom).
    /// Origin stays the same; only the scale factor changes.
    func scaled(by factor: CGFloat) -> CoordinateTransform {
        CoordinateTransform(origin: origin, scale: scale * factor)
    }

    /// Return a new transform scaled around a specific screen-space anchor point.
    /// This keeps the anchor point fixed during zoom.
    func scaled(by factor: CGFloat, anchor: CGPoint) -> CoordinateTransform {
        let newScale = scale * factor
        // The math-space point under the anchor stays under the anchor
        let mathAnchor = toMath(anchor)
        let newOrigin = CGPoint(
            x: anchor.x - mathAnchor.x * newScale,
            y: anchor.y + mathAnchor.y * newScale
        )
        return CoordinateTransform(origin: newOrigin, scale: newScale)
    }

    // MARK: - Visible Range

    /// Returns the math-space X range visible on screen for a given screen width.
    func visibleXRange(screenWidth: CGFloat) -> ClosedRange<Double> {
        let left = toMath(CGPoint(x: 0, y: 0)).x
        let right = toMath(CGPoint(x: screenWidth, y: 0)).x
        return Double(left)...Double(right)
    }

    /// Returns the math-space Y range visible on screen for a given screen height.
    func visibleYRange(screenHeight: CGFloat) -> ClosedRange<Double> {
        // Screen y=0 is top (positive math Y), screen y=height is bottom (negative math Y)
        let top = toMath(CGPoint(x: 0, y: 0)).y
        let bottom = toMath(CGPoint(x: 0, y: screenHeight)).y
        return Double(bottom)...Double(top)
    }

    // MARK: - Factory Methods

    /// Create a transform that centers (0,0) in the given size with the specified scale.
    static func centered(in size: CGSize, scale: CGFloat) -> CoordinateTransform {
        CoordinateTransform(
            origin: CGPoint(x: size.width / 2, y: size.height / 2),
            scale: scale
        )
    }

    /// Create a transform that fits a given math range into a screen size with padding.
    /// - Parameters:
    ///   - xRange: math-space X range to fit
    ///   - yRange: math-space Y range to fit
    ///   - size: screen size to fit into
    ///   - padding: screen-space padding on each side
    static func fitting(
        xRange: ClosedRange<Double>,
        yRange: ClosedRange<Double>,
        in size: CGSize,
        padding: CGFloat = 16
    ) -> CoordinateTransform {
        let mathWidth = CGFloat(xRange.upperBound - xRange.lowerBound)
        let mathHeight = CGFloat(yRange.upperBound - yRange.lowerBound)
        let availableWidth = size.width - 2 * padding
        let availableHeight = size.height - 2 * padding

        // Use the smaller scale to fit both dimensions
        let scaleX = mathWidth > 0 ? availableWidth / mathWidth : 1
        let scaleY = mathHeight > 0 ? availableHeight / mathHeight : 1
        let fitScale = min(scaleX, scaleY)

        // Center the math origin in screen space
        let mathCenterX = CGFloat(xRange.lowerBound + xRange.upperBound) / 2
        let mathCenterY = CGFloat(yRange.lowerBound + yRange.upperBound) / 2
        let originX = size.width / 2 - mathCenterX * fitScale
        let originY = size.height / 2 + mathCenterY * fitScale

        return CoordinateTransform(
            origin: CGPoint(x: originX, y: originY),
            scale: fitScale
        )
    }
}
