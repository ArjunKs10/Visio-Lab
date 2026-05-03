import Foundation

struct LessonContent: Identifiable {
    let id: String
    let topicID: TopicID
    let title: String
    let subtitle: String
    let estimatedMinutes: Int
    let sections: [LessonSection]
    let keyFormulas: [FormulaBlock]
}
