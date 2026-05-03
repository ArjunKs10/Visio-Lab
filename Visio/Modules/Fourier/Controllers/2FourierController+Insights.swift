import Foundation

extension FourierController: InsightProvider {
    func insights() -> [ContextInsight] {
        var results: [ContextInsight] = []
        
        let n = state.harmonicCount
        
        if n == 1 {
            results.append(ContextInsight(
                heading: "1 harmonic — just a sine wave",
                body: "What you see is the fundamental frequency. No matter the target shape, every Fourier series starts here — a simple smooth wave.",
                icon: "waveform"
            ))
        } else if n < 5 {
            results.append(ContextInsight(
                heading: "\(n) harmonics — shape is emerging",
                body: "Look at the curve — the overall shape is forming, but sharp edges are still rounded. Higher frequencies are needed to capture sudden changes.",
                icon: "waveform"
            ))
        } else {
            results.append(ContextInsight(
                heading: "\(n) harmonics — very close approximation",
                body: "The curve closely matches the target. Notice the small ripples near sharp edges — this is Gibbs phenomenon. Even with infinite harmonics, that overshoot never disappears, it only gets narrower.",
                icon: "waveform"
            ))
        }
        
        switch state.shape {
        case .square:
            results.append(ContextInsight(
                heading: "Square wave — only odd harmonics",
                body: "Watch the circles — every second harmonic is tiny or missing. That’s because even harmonics contribute zero. Only 1st, 3rd, 5th... shape the wave.",
                icon: "info.circle"
            ))
            
        case .sawtooth:
            results.append(ContextInsight(
                heading: "Sawtooth — all harmonics active",
                body: "Every harmonic contributes here. Each circle gets progressively smaller (1/n), which is why it takes many terms to sharpen the edges.",
                icon: "info.circle"
            ))
            
        case .triangle:
            results.append(ContextInsight(
                heading: "Triangle — fastest convergence",
                body: "Notice how quickly the shape becomes accurate. That’s because amplitudes shrink as 1/n², much faster than other waves — fewer harmonics are needed.",
                icon: "info.circle"
            ))
        }
        
        if n > 3 {
            results.append(ContextInsight(
                heading: "More harmonics = more detail",
                body: "Each added harmonic captures finer features of the shape. Lower harmonics define the overall form, higher ones refine sharp edges.",
                icon: "sparkles"
            ))
        }
        
        return results
    }
}
