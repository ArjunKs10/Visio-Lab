import SwiftUI

/// Root view for the Fourier Series module.
struct FourierView: View {
    @StateObject private var controller = FourierController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                // Interactive Canvas
                FourierCanvasView(controller: controller)
                
                // Parameter Controls
                HarmonicSliderPanel(controller: controller)
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Fourier Series")
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
        .onDisappear {
            controller.reset()
        }
    }
}

#Preview {
    NavigationStack {
        FourierView()
    }
}
