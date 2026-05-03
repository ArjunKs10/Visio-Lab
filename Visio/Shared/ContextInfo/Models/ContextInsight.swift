import Foundation

struct ContextInsight: Identifiable {
    let id = UUID()
    let heading: String
    let body: String
    let icon: String
    var highlightValue: String? = nil
}
