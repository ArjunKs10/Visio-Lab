import Foundation

/// Analyzes the ProjectileState to provide max height, range, and flight time.
struct ProjectileAnalytics {
    let state: ProjectileState
    
    /// Total time the projectile is in the air (s)
    var maxFlightTime: Double {
        (2 * state.vy0) / state.g
    }
    
    /// Maximum vertical height reached (m)
    var maxHeight: Double {
        (state.vy0 * state.vy0) / (2 * state.g)
    }
    
    /// Total horizontal distance covered (m)
    var range: Double {
        state.vx0 * maxFlightTime
    }
}
