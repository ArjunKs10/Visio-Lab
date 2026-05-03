import SwiftUI

struct LessonSectionView: View {
    let section: LessonSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.heading)
                .font(.headline)
                .foregroundColor(AppColors.label)
            
            Text(section.body)
                .font(.body)
                .foregroundColor(AppColors.label)
                .lineSpacing(6)
            
            if let callout = section.callout {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: callout.icon)
                        .font(.title3)
                        .foregroundColor(AppColors.mathAccent)
                        .frame(width: 24)
                    
                    Text(callout.text)
                        .font(.subheadline)
                        .foregroundColor(AppColors.label)
                        .lineSpacing(4)
                }
                .padding()
                .background(AppColors.mathAccent.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius))
            }
        }
        .padding(.bottom, 16)
    }
}
