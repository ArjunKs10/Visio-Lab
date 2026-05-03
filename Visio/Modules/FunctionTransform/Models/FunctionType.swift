import Foundation

/// Defines the base mathematical functions available for transformation.
enum FunctionType: String, CaseIterable, Identifiable {
    case sine = "Sine"
    case cosine = "Cosine"
    case quadratic = "Quadratic"
    case linear = "Linear"
    
    var id: String { rawValue }
    
    /// Evaluate the base function f(x) at a given math X coordinate
    func evaluate(at x: Double) -> Double {
        switch self {
        case .sine: return sin(x)
        case .cosine: return cos(x)
        case .quadratic: return x * x
        case .linear: return x
        }
    }
}
