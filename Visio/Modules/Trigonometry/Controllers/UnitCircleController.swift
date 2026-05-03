import Foundation
import Combine
import CoreGraphics

/// Controller for the Unit Circle module.
/// Handles angle updates and touch dragging logic with snapping.
class UnitCircleController: ObservableObject {
    
    @Published var state = TrigState(angleDegrees: 45.0)
    
    /// Update angle directly (e.g. from slider)
    func updateAngle(degrees: Double) {
        state.angleDegrees = degrees
    }
    
    /// Handle drag gesture from the canvas
    func handleDrag(to screenPoint: CGPoint, transform: CoordinateTransform) {
        let mathPoint = transform.toMath(screenPoint)
        
        // Calculate angle from origin to the touched point
        let angleRad = Double(atan2(mathPoint.y, mathPoint.x))
        var angleDeg = angleRad.toDegrees
        
        // Normalize to [0, 360) for dragging ease
        if angleDeg < 0 {
            angleDeg += 360
        }
        
        // Snap to common angles if close enough
        for snapAngle in AppDimensions.snapAngles {
            // Check both standard distance and distance across the 0/360 wrap
            let dist = min(abs(angleDeg - snapAngle), abs(angleDeg - (snapAngle - 360)), abs(angleDeg - (snapAngle + 360)))
            if dist < AppDimensions.snapThreshold {
                angleDeg = snapAngle
                break
            }
        }
        
        state.angleDegrees = angleDeg
    }
    
    /// Reset to initial state
    func reset() {
        state.angleDegrees = 45.0
    }
}
