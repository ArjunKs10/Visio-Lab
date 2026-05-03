import SwiftUI

struct LessonDetailView: View {
    let lesson: LessonContent
    @ObservedObject var controller: LessonsController
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // HERO SECTION
                VStack(alignment: .center, spacing: 16) {
                    Image(systemName: lesson.topicID.sfSymbol)
                        .font(.system(size: 64))
                        .foregroundColor(lesson.topicID.color)
                    
                    Text(lesson.title)
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                    
                    Text(lesson.subtitle)
                        .font(.title3)
                        .foregroundColor(AppColors.secondaryLabel)
                        .multilineTextAlignment(.center)
                    
                    Text("~\(lesson.estimatedMinutes) min read")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(AppColors.secondaryBackground)
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                
                // KEY FORMULAS BLOCK
                if !lesson.keyFormulas.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Key Formulas")
                            .font(.title2.weight(.bold))
                        
                        ForEach(lesson.keyFormulas) { block in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(block.label)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(AppColors.secondaryLabel)
                                
                                Text(block.formula)
                                    .font(.system(.title3, design: .monospaced, weight: .bold))
                                    .foregroundColor(lesson.topicID.color)
                                
                                if !block.variables.isEmpty {
                                    VStack(alignment: .leading, spacing: 2) {
                                        ForEach(block.variables, id: \.self) { variable in
                                            Text(variable)
                                                .font(.caption)
                                                .foregroundColor(AppColors.tertiaryLabel)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(AppColors.secondaryBackground)
                            .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
                        }
                    }
                    .padding(.bottom, 12)
                }
                
                // LESSON SECTIONS
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(lesson.sections) { section in
                        LessonSectionView(section: section)
                    }
                }
                
                // TRY IT IN VISUALISER BUTTON
                Button {
                    router.selectedTab = 1
                    router.pendingTopic = lesson.topicID
                } label: {
                    HStack {
                        Spacer()
                        Text("Try \(lesson.title) in Visualiser")
                            .font(.headline)
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title3)
                        Spacer()
                    }
                    .padding()
                    .background(lesson.topicID.color)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: AppDimensions.buttonCornerRadius))
                }
                .padding(.vertical, 24)
                
                // COMPLETION DETECTION (Bottom anchor)
                Color.clear
                    .frame(height: 1)
                    .onAppear {
                        controller.markComplete(id: lesson.id)
                    }
            }
            .padding(.horizontal, AppDimensions.screenPadding)
        }
        .background(AppColors.background)
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
