import Foundation

extension UnitCircleController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        let rawAngle = state.angleDegrees
        let normalizedAngle = (rawAngle.truncatingRemainder(dividingBy: 360) + 360)
            .truncatingRemainder(dividingBy: 360)
        
        let quadrant: String
        if normalizedAngle < 90 { quadrant = "1st" }
        else if normalizedAngle < 180 { quadrant = "2nd" }
        else if normalizedAngle < 270 { quadrant = "3rd" }
        else { quadrant = "4th" }
        
        let direction: String
        if state.sinValue >= 0 && state.cosValue >= 0 { direction = "up-right" }
        else if state.sinValue >= 0 && state.cosValue < 0 { direction = "up-left" }
        else if state.sinValue < 0 && state.cosValue < 0 { direction = "down-left" }
        else { direction = "down-right" }
        
        results.append(ContextInsight(
            heading: "Angle = \(Int(normalizedAngle))° (\(quadrant) quadrant)",
            body: "Look at the radius line — it points \(direction). As you move around the circle, sin and cos change based on this direction.",
            icon: "dial.medium"
        ))
        
        let sinValStr = String(format: "%.2f", state.sinValue)
        var sinBody = "sin is the vertical (y) coordinate of the point. Right now it's \(sinValStr)."
        
        if abs(state.sinValue) < 0.05 {
            sinBody = "The point is very close to the x-axis, so its vertical height is nearly zero — that’s why sin is close to 0."
        } else if state.sinValue > 0.95 {
            sinBody = "You’re near the top of the circle — maximum vertical height. This is where sin reaches its peak value of 1."
        } else if state.sinValue < -0.95 {
            sinBody = "You’re near the bottom of the circle — minimum vertical height. sin is close to -1 here."
        }
        
        results.append(ContextInsight(
            heading: "sin(\(Int(normalizedAngle))°) = \(sinValStr)",
            body: sinBody,
            icon: "arrow.up.and.down",
            highlightValue: "sin = \(sinValStr)"
        ))
        
        let cosValStr = String(format: "%.2f", state.cosValue)
        results.append(ContextInsight(
            heading: "cos(\(Int(normalizedAngle))°) = \(cosValStr)",
            body: "cos is the horizontal (x) coordinate. Watch how it shrinks as the point moves toward the top, and becomes negative on the left side.",
            icon: "arrow.left.and.right",
            highlightValue: "cos = \(cosValStr)"
        ))
        
        let identityVal = state.sinValue * state.sinValue + state.cosValue * state.cosValue
        let identityStr = String(format: "%.2f", identityVal)
        
        results.append(ContextInsight(
            heading: "sin² + cos² = 1",
            body: "Try any angle — sin² + cos² ≈ \(identityStr). This is always true on the unit circle. It comes directly from the circle’s radius being 1.",
            icon: "circle"
        ))
        
        let tanValStr = String(format: "%.2f", state.tanValue)
        let specialAngles: Set<Double> = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360]
        
        if abs(state.cosValue) < 0.05 {
            results.append(ContextInsight(
                heading: "tan is undefined here",
                body: "The radius line is nearly vertical. Since tan = sin/cos, dividing by a value close to zero makes it undefined.",
                icon: "exclamationmark.triangle"
            ))
        } else if specialAngles.contains(round(normalizedAngle)) {
            results.append(ContextInsight(
                heading: "Special angle",
                body: "This angle has exact known values for sin, cos, and tan. Try moving slightly away to see how quickly the values change.",
                icon: "star.fill"
            ))
        } else {
            results.append(ContextInsight(
                heading: "tan(\(Int(normalizedAngle))°) = \(tanValStr)",
                body: "tan represents the slope of the radius line. Notice how steep it becomes as the line approaches vertical.",
                icon: "arrow.up.right"
            ))
        }
        
        return results
    }
}
