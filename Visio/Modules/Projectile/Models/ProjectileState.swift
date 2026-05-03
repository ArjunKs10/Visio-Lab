import Foundation

/// Data model for Projectile Motion physics state.
/// Tracks initial conditions, current time, and computes position/velocity.
struct ProjectileState {
    /// Initial velocity (m/s)
    var v0: Double = 25.0
    
    /// Launch angle (degrees)
    var angleDegrees: Double = 45.0
    
    /// Elapsed flight time (s)
    var time: Double = 0.0
    
    /// Is the simulation currently running?
    var isPlaying: Bool = false
    
    /// Gravity constant (m/s²)
    let g: Double = 9.81
    
    // MARK: - Computed Physics
    
    var angleRadians: Double {
        angleDegrees.toRadians
    }
    
    /// Initial horizontal velocity
    var vx0: Double {
        v0 * cos(angleRadians)
    }
    
    /// Initial vertical velocity
    var vy0: Double {
        v0 * sin(angleRadians)
    }
    
    /// Current horizontal velocity (constant in absence of air resistance)
    var currentVx: Double {
        vx0
    }
    
    /// Current vertical velocity (affected by gravity)
    var currentVy: Double {
        vy0 - g * time
    }
    
    /// Current horizontal position (x)
    var currentX: Double {
        vx0 * time
    }
    
    /// Current vertical position (y), constrained to not fall below 0
    var currentY: Double {
        max(0, vy0 * time - 0.5 * g * time * time)
    }
    
    /// Has the projectile hit the ground?
    var hasLanded: Bool {
        return time > 0 && currentY <= 0
    }
}
