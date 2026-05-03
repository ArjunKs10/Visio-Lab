import Foundation

/// Data model for the Trigonometry (Unit Circle) module.
/// Computes sin, cos, and tan based on the current angle.
struct TrigState {
    /// Angle in degrees (can be negative or > 360)
    var angleDegrees: Double = 45.0
    
    /// Angle converted to radians for math functions
    var angleRadians: Double {
        angleDegrees.toRadians
    }
    
    /// Sine value (Y coordinate on unit circle)
    var sinValue: Double {
        sin(angleRadians)
    }
    
    /// Cosine value (X coordinate on unit circle)
    var cosValue: Double {
        cos(angleRadians)
    }
    
    /// Tangent value (slope). Handles exact 90°/270° as infinity.
    var tanValue: Double {
        let normalized = angleDegrees.normalizedDegrees
        // Use a small epsilon to catch floating point rounding at 90 and 270
        if abs(normalized - 90) < 0.001 || abs(normalized - 270) < 0.001 {
            return Double.infinity
        }
        return tan(angleRadians)
    }
    
    /// Mathematical coordinate of the point on the unit circle
    var point: CGPoint {
        CGPoint(x: cosValue, y: sinValue)
    }
}
