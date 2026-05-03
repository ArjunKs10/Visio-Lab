import Foundation

/// Mathematical state representing a 2D wave interference system.
/// Two point sources emit coherent waves with a shared wavelength.
struct WaveState {
    /// Position of Source 1 in math space
    var source1: CGPoint = CGPoint(x: -2.0, y: 0.0)
    
    /// Position of Source 2 in math space
    var source2: CGPoint = CGPoint(x: 2.0, y: 0.0)
    
    /// Wavelength of both sources (meters)
    var wavelength: Double = 1.0
}
