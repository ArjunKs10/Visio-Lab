import Foundation
import CoreGraphics

/// State for the Fourier Series module
struct FourierState {
    /// The mathematical target wave to approximate
    var shape: TargetShape = .square
    
    /// Number of epicycles / harmonics (N) to calculate
    var harmonicCount: Int = 5
    
    /// Animation time progression
    var time: Double = 0.0
    
    /// Animation running state
    var isPlaying: Bool = false
}
