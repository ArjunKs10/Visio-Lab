import Foundation

extension FourierController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        let n = state.harmonicCount
        
        if n == 1 {
            results.append(ContextInsight(
                heading: "1 harmonic — just a sine wave",
                body: "With only the fundamental frequency, the result is a pure sine wave. No matter how different the target shape is, this is always where you start.",
                icon: "waveform"
            ))
        } else if n < 5 {
            results.append(ContextInsight(
                heading: "\(n) harmonics — rough approximation",
                body: "You can see the general shape forming but the corners are very rounded. More terms are needed to capture the sharp edges.",
                icon: "waveform"
            ))
        } else {
            results.append(ContextInsight(
                heading: "\(n) harmonics — close approximation",
                body: "The shape is close to the target. Notice the small oscillations near sharp edges — that is Gibbs phenomenon and it never fully disappears.",
                icon: "waveform"
            ))
        }
        
        if state.shape == .square {
            results.append(ContextInsight(
                heading: "Square wave — only odd harmonics",
                body: "A square wave contains only the 1st, 3rd, 5th harmonics... The even harmonics (2nd, 4th...) contribute zero. This is why the circles alternate between large and tiny.",
                icon: "info.circle"
            ))
        } else if state.shape == .sawtooth {
            results.append(ContextInsight(
                heading: "Sawtooth — all harmonics",
                body: "Unlike the square wave, a sawtooth contains ALL harmonics. Each one is smaller than the last (1/n amplitude). This is why you need more terms to get a good approximation.",
                icon: "info.circle"
            ))
        } else if state.shape == .triangle {
            results.append(ContextInsight(
                heading: "Triangle — fastest convergence",
                body: "Triangle wave amplitudes fall off as 1/n² instead of 1/n. This means it converges much faster — you need fewer harmonics for a good approximation than square or sawtooth.",
                icon: "info.circle"
            ))
        }
        
        return results
    }
}
