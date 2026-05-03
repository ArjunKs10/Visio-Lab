import Foundation

struct LessonSection: Identifiable {
    let id = UUID()
    let heading: String
    let body: String
    let callout: Callout?
    
    struct Callout {
        let icon: String
        let text: String
    }
}
