import SwiftUI

/// Root view for the Projectile Motion physics module.
struct ProjectileView: View {
    @StateObject private var controller = ProjectileController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                // Visual Canvas
                ProjectileCanvasView(controller: controller)
                
                // Control Panel
                ProjectileControlPanel(controller: controller)
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Projectile Motion")
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
            // Stop engine when leaving the screen
            controller.reset()
        }
    }
}

#Preview {
    NavigationStack {
        ProjectileView()
    }
}
