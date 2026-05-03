import SwiftUI

/// Root view for the Wave Interference module.
struct WaveInterferenceView: View {
    @StateObject private var controller = WaveController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                // Interactive Grid
                WaveCanvasView(controller: controller)
                
                // Controls
                WaveControlPanel(controller: controller)
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Wave Interference")
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button {
                        showInsightPanel = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    ResetButton { controller.reset() }
                }
            }
        }
        .sheet(isPresented: $showInsightPanel) {
            InsightPanelView(insights: controller.insights())
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    NavigationStack {
        WaveInterferenceView()
    }
}
