import SwiftUI

/// Root view for the Function Transforms module.
/// Combines the graph canvas and parameter sliders.
struct FunctionTransformView: View {
    @StateObject private var controller = FunctionTransformController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                // Canvas Area
                GraphCanvasView(controller: controller)
                
                // Controls Area
                ParameterSliderPanel(controller: controller)
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Function Transforms")
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
        FunctionTransformView()
    }
}
