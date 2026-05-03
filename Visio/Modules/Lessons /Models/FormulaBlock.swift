import Foundation

struct FormulaBlock: Identifiable {
    let id = UUID()
    let label: String
    let formula: String
    let variables: [String]
}
