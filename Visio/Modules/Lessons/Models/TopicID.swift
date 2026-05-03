import Foundation
import SwiftUI

/// Unique identifiers for the major topics in the app.
/// Used to link lessons to their corresponding visualiser modules.
enum TopicID: String, CaseIterable, Identifiable, Hashable {
    case unitCircle = "Unit Circle"
    case functionTransforms = "Function Transforms"
    case fourierSeries = "Fourier Series"
    case projectileMotion = "Projectile Motion"
    case simpleHarmonicMotion = "Simple Harmonic Motion"
    case waveInterference = "Wave Interference"
    
    var id: String { rawValue }
    
    var isMath: Bool {
        switch self {
        case .unitCircle, .functionTransforms, .fourierSeries: return true
        default: return false
        }
    }
    
    var sfSymbol: String {
        switch self {
        case .unitCircle: return "circle.dotted"
        case .functionTransforms: return "function"
        case .fourierSeries: return "waveform"
        case .projectileMotion: return "arrow.up.right"
        case .simpleHarmonicMotion: return "arrow.left.and.right"
        case .waveInterference: return "wave.3.right"
        }
    }
    
    var color: Color {
        isMath ? AppColors.mathAccent : AppColors.physicsAccent
    }
}
