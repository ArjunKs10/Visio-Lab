import Foundation

/// Modes for Simple Harmonic Motion
enum SHMMode: String, CaseIterable, Identifiable {
    case pendulum = "Pendulum"
    case spring = "Spring-Mass"
    var id: String { rawValue }
}

/// Physics state for SHM.
/// Evaluates x(t) = A * cos(ωt) analytically based on parameters.
struct SHMState {
    var mode: SHMMode = .pendulum
    
    // Global parameters
    var amplitude: Double = 1.0    // A (meters or radians)
    var mass: Double = 1.0         // m (kg)
    var time: Double = 0.0         // t (seconds)
    var isPlaying: Bool = false
    
    // Mode-specific parameters
    var springK: Double = 10.0     // Spring constant (N/m)
    var length: Double = 2.0       // Pendulum length (m)
    let g: Double = 9.81           // Gravity
    
    /// Angular frequency (ω)
    var omega: Double {
        switch mode {
        case .spring: return sqrt(springK / mass)
        case .pendulum: return sqrt(g / length)
        }
    }
    
    /// Period (T)
    var period: Double {
        2 * .pi / omega
    }
    
    /// Current displacement (x for spring, theta for pendulum)
    var displacement: Double {
        amplitude * cos(omega * time)
    }
}
