import Foundation

/// Data model for transformation parameters a, b, c, d
/// Equation: y = a * f(b(x - c)) + d
struct TransformParameters {
    /// Vertical stretch / Amplitude
    var a: Double = 1.0
    
    /// Horizontal stretch / Frequency multiplier
    var b: Double = 1.0
    
    /// Horizontal shift / Phase shift
    var c: Double = 0.0
    
    /// Vertical shift
    var d: Double = 0.0
    
    /// Evaluate the full transformed function at math X
    func evaluate(at x: Double, type: FunctionType) -> Double {
        return a * type.evaluate(at: b * (x - c)) + d
    }
}
