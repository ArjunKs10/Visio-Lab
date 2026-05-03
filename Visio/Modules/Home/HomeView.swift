import SwiftUI

/// 2-column grid of TopicCards
struct HomeView: View {
    @StateObject private var controller = HomeController()
    @EnvironmentObject var router: NavigationRouter

    private let columns = [
        GridItem(.flexible(), spacing: AppDimensions.gridSpacing),
        GridItem(.flexible(), spacing: AppDimensions.gridSpacing)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Subtitle
                Text("Visual Intuition")
                    .font(AppFonts.title3)
                    .foregroundColor(AppColors.secondaryLabel)
                    .padding(.horizontal, AppDimensions.screenPadding)
                    .padding(.bottom, AppDimensions.sectionSpacing)

                // Grid
                LazyVGrid(columns: columns, spacing: AppDimensions.gridSpacing) {
                    ForEach(controller.topics) { topic in
                        TopicCard(topic: topic) {
                            controller.selectedTopic = topic.name
                        }
                    }
                }
                .padding(.horizontal, AppDimensions.screenPadding)
            }
            .padding(.top, 8)
        }
        .background(AppColors.background)
        .navigationTitle("Visio")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: Binding(
            get: { controller.selectedTopic != nil },
            set: { if !$0 { controller.selectedTopic = nil } }
        )) {
            if let moduleName = controller.selectedTopic {
                destination(for: moduleName)
            }
        }
        .onChange(of: router.pendingTopic) { newValue in
            if let topic = newValue {
                controller.selectedTopic = topic.rawValue
                DispatchQueue.main.async {
                    router.pendingTopic = nil
                }
            }
        }
    }
    
    @ViewBuilder
    private func destination(for moduleName: String) -> some View {
        switch moduleName {
        case "Unit Circle":
            UnitCircleView()
        case "Function Transforms":
            FunctionTransformView()
        case "Fourier Series":
            FourierView()
        case "Projectile Motion":
            ProjectileView()
        case "Simple Harmonic Motion":
            SHMView()
        case "Wave Interference":
            WaveInterferenceView()
        default:
            Text("\(moduleName) — Coming soon")
                .navigationTitle(moduleName)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
