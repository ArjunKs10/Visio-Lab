import Foundation

/// Target waveforms for the Fourier Series approximation
enum TargetShape: String, CaseIterable, Identifiable {
    case square = "Square Wave"
    case sawtooth = "Sawtooth"
    case triangle = "Triangle Wave"
    
    var id: String { rawValue }
    
    /// Returns the amplitude (radius) for the n-th harmonic.
    /// Returns 0 if the harmonic is not present in the series.
    func radiusForHarmonic(n: Int) -> Double {
        switch self {
        case .square:
            // Square wave uses only odd harmonics: 4/(n * pi)
            if n % 2 == 0 { return 0 }
            return (4.0 / (Double(n) * .pi))
            
        case .sawtooth:
            // Sawtooth uses all harmonics: 2 * (-1)^(n+1) / (n * pi)
            let sign = (n % 2 == 0) ? -1.0 : 1.0
            return (2.0 * sign) / (Double(n) * .pi)
            
        case .triangle:
            // Triangle wave uses only odd harmonics: 8/(pi^2 * n^2) * (-1)^((n-1)/2)
            if n % 2 == 0 { return 0 }
            let sign = ((n - 1) / 2) % 2 == 0 ? 1.0 : -1.0
            return sign * (8.0 / (.pi * .pi * Double(n * n)))
        }
    }
}
