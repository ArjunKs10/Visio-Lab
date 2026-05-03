import Foundation

extension ProjectileController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        let isFlying = state.isPlaying
        
        if !isFlying {
            let uStr = String(format: "%.1f", state.v0)
            let rangeStr = String(format: "%.1f", analytics.range)
            let maxHeightStr = String(format: "%.1f", analytics.maxHeight)
            let angle = state.angleDegrees
            
            results.append(ContextInsight(
                heading: "Ready to launch",
                body: "At \(Int(angle))° with \(uStr) m/s, the ball will travel \(rangeStr)m and reach \(maxHeightStr)m. These values are calculated analytically — the simulation simply follows that exact path.",
                icon: "scope"
            ))
            
            if abs(angle - 45.0) < 0.1 {
                results.append(ContextInsight(
                    heading: "45° gives maximum range",
                    body: "At 45°, horizontal and vertical components are perfectly balanced. This makes sin(2θ) = 1, which maximises range. Try 30° or 60° — you'll get the same range but very different trajectories.",
                    icon: "arrow.up.right"
                ))
            } else if angle < 45 {
                results.append(ContextInsight(
                    heading: "Low angle — flatter path",
                    body: "The horizontal velocity is dominant, so the ball travels fast across but doesn’t rise much. Watch how the arc stays shallow. The complementary angle \(Int(90-angle))° produces the same range with a much higher arc.",
                    icon: "arrow.up.right"
                ))
            } else {
                results.append(ContextInsight(
                    heading: "High angle — steeper path",
                    body: "More velocity goes into vertical motion, so the ball climbs higher but lands closer. Compare it with \(Int(90-angle))° — same range, very different shape.",
                    icon: "arrow.up.right"
                ))
            }
            
        } else {
            let vxStr = String(format: "%.1f", state.currentVx)
            let vyStr = String(format: "%.1f", state.currentVy)
            
            results.append(ContextInsight(
                heading: "Velocity at this moment",
                body: "Horizontal: \(vxStr) m/s — this never changes. Vertical: \(vyStr) m/s \(state.currentVy > 0 ? "(still rising)" : "(falling)"). Watch the arrows — red stays constant, green changes due to gravity.",
                icon: "arrow.up.right"
            ))
            
            if abs(state.currentVy) < 0.5 {
                results.append(ContextInsight(
                    heading: "At the highest point",
                    body: "Vertical velocity is nearly zero here. The ball stops rising for an instant before falling. Only horizontal motion remains at this exact moment.",
                    icon: "circle"
                ))
            } else if state.currentVy < 0 {
                results.append(ContextInsight(
                    heading: "Descending",
                    body: "The ball is now falling. Gravity is accelerating it downward, so the vertical speed is increasing again. Notice how the downward arrow grows.",
                    icon: "location.fill"
                ))
            } else {
                results.append(ContextInsight(
                    heading: "Climbing",
                    body: "The ball is rising, but gravity is slowing it down. The vertical velocity is decreasing and will reach zero at the peak.",
                    icon: "location.fill"
                ))
            }
            
            results.append(ContextInsight(
                heading: "Energy transformation",
                body: "As the ball rises, kinetic energy converts into potential energy. At the top, potential energy is maximum. As it falls, that energy converts back into motion.",
                icon: "bolt"
            ))
        }
        
        return results
    }
}
