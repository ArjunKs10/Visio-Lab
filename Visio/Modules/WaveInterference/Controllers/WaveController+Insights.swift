import Foundation

extension WaveController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        results.append(ContextInsight(
            heading: "Interference pattern",
            body: "Blue regions show constructive interference — waves arrive in phase and reinforce each other. Red regions show destructive interference — waves cancel out.",
            icon: "waveform"
        ))
        
        let dx = state.source2.x - state.source1.x
        let dy = state.source2.y - state.source1.y
        let distance = hypot(dx, dy)
        
        let distanceStr = String(format: "%.1f", distance)
        let wlStr = String(format: "%.1f", state.wavelength)
        
        results.append(ContextInsight(
            heading: "Source separation = \(distanceStr)m",
            body: "Compare this distance with the wavelength (\(wlStr)m). This ratio controls how tightly packed the bright and dark bands are.",
            icon: "slider.horizontal.3"
        ))
        
        results.append(ContextInsight(
            heading: "Why the pattern forms",
            body: "At every point, the difference in distance from the two sources determines the result. If that difference is a whole multiple of the wavelength (nλ), the waves reinforce. If it’s a half multiple ((n + ½)λ), they cancel.",
            icon: "function"
        ))

        results.append(ContextInsight(
            heading: "Symmetry of the pattern",
            body: "Notice how the pattern is symmetric between the two sources. Points exactly midway from both sources always show constructive interference because the path difference is zero.",
            icon: "circle.grid.cross"
        ))
        
        if state.wavelength < 0.7 {
            results.append(ContextInsight(
                heading: "Short wavelength",
                body: "The waves oscillate rapidly, so the interference bands are tightly packed. You see more fringes in the same space.",
                icon: "arrow.left.and.right"
            ))
        } else if state.wavelength > 1.5 {
            results.append(ContextInsight(
                heading: "Long wavelength",
                body: "The waves change slowly, so the interference bands spread out. Fewer fringes appear across the screen.",
                icon: "arrow.left.and.right"
            ))
        }

        if distance < 2.0 {
            results.append(ContextInsight(
                heading: "Sources are close together",
                body: "When the sources are close, the pattern spreads out and the bands are wider. The two waves behave more like a single source.",
                icon: "arrow.left.and.right"
            ))
        } else if distance > 5.0 {
            results.append(ContextInsight(
                heading: "Sources are far apart",
                body: "With greater separation, more interference bands appear. The pattern becomes more complex and tightly spaced.",
                icon: "arrow.left.and.right"
            ))
        }
        
        return results
    }
}
