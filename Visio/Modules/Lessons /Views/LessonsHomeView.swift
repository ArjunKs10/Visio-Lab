import SwiftUI

struct LessonsHomeView: View {
    @StateObject private var controller = LessonsController()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppDimensions.sectionSpacing) {
                
                let mathLessons = controller.lessons.filter { $0.topicID.isMath }
                if !mathLessons.isEmpty {
                    SectionView(title: "Mathematics", lessons: mathLessons, controller: controller)
                }
                
                let physicsLessons = controller.lessons.filter { !$0.topicID.isMath }
                if !physicsLessons.isEmpty {
                    SectionView(title: "Physics", lessons: physicsLessons, controller: controller)
                }
            }
            .padding(.horizontal, AppDimensions.screenPadding)
            .padding(.top, 8)
        }
        .background(AppColors.background)
        .navigationTitle("Learn")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Extracting the section rendering to keep it clean
fileprivate struct SectionView: View {
    let title: String
    let lessons: [LessonContent]
    @ObservedObject var controller: LessonsController
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppDimensions.itemSpacing) {
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundColor(AppColors.secondaryLabel)
                .padding(.bottom, 4)
            
            ForEach(lessons) { lesson in
                NavigationLink(destination: LessonDetailView(lesson: lesson, controller: controller)) {
                    LessonCardView(
                        lesson: lesson,
                        isCompleted: controller.completedLessonIDs.contains(lesson.id)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}
