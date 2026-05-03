import SwiftUI

struct InsightPanelView: View {
    let insights: [ContextInsight]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                Text("What's happening?")
                    .font(.headline)
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .foregroundColor(AppColors.mathAccent)
                .fontWeight(.semibold)
            }
            .padding()
            
            Divider()
            
            // Insight cards, scrollable
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(insights) { insight in
                        InsightCardView(insight: insight)
                    }
                }
                .padding()
            }
            
            // Footer
            Text("Interact with the visualiser to see these insights update.")
                .font(.caption)
                .foregroundColor(AppColors.secondaryLabel)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 12)
        }
        .background(AppColors.background)
    }
}
