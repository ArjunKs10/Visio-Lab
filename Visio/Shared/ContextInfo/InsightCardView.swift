import SwiftUI

struct InsightCardView: View {
    let insight: ContextInsight
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: insight.icon)
                .font(.title3)
                .foregroundColor(AppColors.mathAccent)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                if let hv = insight.highlightValue {
                    Text(hv)
                        .font(.system(.subheadline, design: .monospaced, weight: .bold))
                        .foregroundColor(AppColors.mathAccent)
                }
                
                Text(insight.heading)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(AppColors.label)
                
                Text(insight.body)
                    .font(.subheadline)
                    .foregroundColor(AppColors.secondaryLabel)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
