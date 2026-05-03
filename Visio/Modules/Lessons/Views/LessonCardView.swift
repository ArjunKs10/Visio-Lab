import SwiftUI

struct LessonCardView: View {
    let lesson: LessonContent
    let isCompleted: Bool
    
    var body: some View {
        HStack(spacing: AppDimensions.itemSpacing) {
            // Leading Icon
            ZStack {
                Circle()
                    .fill(lesson.topicID.color.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: lesson.topicID.sfSymbol)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(lesson.topicID.color)
            }
            
            // Center Content
            VStack(alignment: .leading, spacing: 4) {
                Text(lesson.title)
                    .font(.headline)
                    .foregroundColor(AppColors.label)
                
                Text(lesson.subtitle)
                    .font(.caption)
                    .foregroundColor(AppColors.secondaryLabel)
                    .lineLimit(1)
                
                Text("~\(lesson.estimatedMinutes) min read")
                    .font(.caption2)
                    .foregroundColor(AppColors.tertiaryLabel)
            }
            
            Spacer()
            
            // Trailing Indicator
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.green)
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.tertiaryLabel)
            }
        }
        .padding(AppDimensions.cardPadding)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius, style: .continuous))
        .shadow(color: Color.black.opacity(0.06), radius: AppDimensions.cardShadowRadius, x: 0, y: 1)
    }
}
