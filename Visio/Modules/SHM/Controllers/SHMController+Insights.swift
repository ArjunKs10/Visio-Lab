import Foundation

extension SHMController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        let displacement = state.displacement
        let amplitude = state.amplitude
        let absDisp = abs(displacement)
        
        if absDisp > 0.85 * amplitude {
            results.append(ContextInsight(
                heading: "Near maximum displacement",
                body: "The \(state.mode == .pendulum ? "bob" : "mass") is near its extreme position. Velocity is almost zero, but the restoring force is strongest here — it’s about to reverse direction.",
                icon: "arrow.left.and.right"
            ))
            
            results.append(ContextInsight(
                heading: "Energy is mostly potential",
                body: "At this point, almost all the energy is stored as potential energy. Very little is kinetic since the motion is about to change direction.",
                icon: "bolt"
            ))
            
        } else if absDisp < 0.1 * amplitude {
            results.append(ContextInsight(
                heading: "Passing through equilibrium",
                body: "This is the centre point. Displacement is zero, so restoring force is zero — but velocity is maximum. The system moves fastest here.",
                icon: "arrow.left.and.right"
            ))
            
            results.append(ContextInsight(
                heading: "Energy is mostly kinetic",
                body: "All the stored potential energy has converted into motion. This is why speed is highest at the centre.",
                icon: "bolt"
            ))
            
        } else {
            let percent = Int((absDisp / amplitude) * 100)
            let dispStr = String(format: "%.2f", displacement)
            
            results.append(ContextInsight(
                heading: "Displacement = \(dispStr)",
                body: "The \(state.mode == .pendulum ? "bob" : "mass") is \(percent)% of the way to its maximum displacement. The restoring force increases as it moves further away from equilibrium.",
                icon: "arrow.left.and.right"
            ))
            
            results.append(ContextInsight(
                heading: "Energy is being exchanged",
                body: "Energy is continuously shifting between kinetic and potential. The further from the centre, the more potential energy dominates.",
                icon: "bolt"
            ))
        }
        
        let tStr = String(format: "%.2f", state.period)
        
        if state.mode == .pendulum {
            let lStr = String(format: "%.1f", state.length)
            
            results.append(ContextInsight(
                heading: "Period = \(tStr)s",
                body: "T = 2π√(L/g). Your pendulum is \(lStr)m long. Increasing length increases the period, but only by a square-root relation — doubling length increases time by about 1.41×.",
                icon: "timer"
            ))
            
            results.append(ContextInsight(
                heading: "Length controls speed of motion",
                body: "A longer pendulum swings more slowly because gravity has a weaker restoring effect over the longer arc.",
                icon: "info.circle"
            ))
            
        } else {
            let kStr = String(format: "%.1f", state.springK)
            let mStr = String(format: "%.1f", state.mass)
            
            results.append(ContextInsight(
                heading: "Period = \(tStr)s",
                body: "T = 2π√(m/k). Your system has k = \(kStr) N/m and mass = \(mStr) kg. Increasing mass slows motion, while a stiffer spring speeds it up.",
                icon: "timer"
            ))
            
            results.append(ContextInsight(
                heading: "Stiffness vs inertia",
                body: "The spring pulls the system back (k), while mass resists motion (m). The balance between these determines how fast the system oscillates.",
                icon: "info.circle"
            ))
        }
        
        return results
    }
}
