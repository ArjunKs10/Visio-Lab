import Foundation
import Combine

/// Manages the state for the Function Transforms module
class FunctionTransformController: ObservableObject {
    @Published var type: FunctionType = .sine
    @Published var params = TransformParameters()
    
    /// Resets parameters to the default f(x) state
    func reset() {
        type = .sine
        params = TransformParameters()
    }
    
    /// Dynamically constructs the mathematical equation string based on current parameters
    var equationString: String {
        // Format 'a'
        var aStr = ""
        if params.a != 1.0 {
            if params.a == -1.0 {
                aStr = "-"
            } else {
                aStr = String(format: "%.1f", params.a) + " "
            }
        }
        
        // Format 'c'
        var cStr = "x"
        if params.c > 0 {
            cStr = "(x - \(String(format: "%.1f", params.c)))"
        } else if params.c < 0 {
            cStr = "(x + \(String(format: "%.1f", abs(params.c))))"
        }
        
        // Format 'b'
        var bStr = cStr
        if params.b != 1.0 {
            if params.b == -1.0 {
                bStr = "-\(cStr)"
            } else {
                bStr = "\(String(format: "%.1f", params.b))\(cStr)"
            }
        }
        
        // Format function type
        var funcStr = ""
        switch type {
        case .sine: funcStr = "sin(\(bStr))"
        case .cosine: funcStr = "cos(\(bStr))"
        case .quadratic:
            // For quadratic, if bStr is just x, we want x² not (x)².
            // If it's an expression, we wrap it in parentheses.
            if bStr == "x" {
                funcStr = "x²"
            } else {
                funcStr = "(\(bStr))²"
            }
        case .linear:
            funcStr = bStr
        }
        
        // Format 'd'
        var dStr = ""
        if params.d > 0 {
            dStr = " + \(String(format: "%.1f", params.d))"
        } else if params.d < 0 {
            dStr = " - \(String(format: "%.1f", abs(params.d)))"
        }
        
        return "y = \(aStr)\(funcStr)\(dStr)"
    }
}
