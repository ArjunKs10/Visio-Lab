import SwiftUI

/// Root view for the Simple Harmonic Motion physics module.
struct SHMView: View {
    @StateObject private var controller = SHMController()
    @State private var showInsightPanel: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppDimensions.sectionSpacing) {
                
                // Mode Picker
                Picker("Mode", selection: Binding(
                    get: { controller.state.mode },
                    set: {
                        controller.state.mode = $0
                        controller.handleModeChange()
                    }
                )) {
                    ForEach(SHMMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                
                // Visual Canvases
                VStack(spacing: AppDimensions.itemSpacing) {
                    if controller.state.mode == .pendulum {
                        PendulumCanvasView(controller: controller)
                            .frame(height: 280)
                    } else {
                        SpringMassCanvasView(controller: controller)
                            .frame(height: 280)
                    }
                    
                    // Live displacement graph
                    SHMGraphView(controller: controller)
                }
                
                // Controls
                SectionCard(title: "Parameters") {
                    VStack(spacing: AppDimensions.itemSpacing) {
                        
                        if controller.state.mode == .pendulum {
                            SliderRow(label: "Initial Angle (θ)", value: $controller.state.amplitude, range: 0.1...2.0, step: 0.1, unit: "rad")
                            SliderRow(label: "Length (L)", value: $controller.state.length, range: 1.0...5.0, step: 0.1, unit: "m")
                        } else {
                            SliderRow(label: "Amplitude (A)", value: $controller.state.amplitude, range: 0.1...5.0, step: 0.1, unit: "m")
                            SliderRow(label: "Mass (m)", value: $controller.state.mass, range: 0.5...10.0, step: 0.5, unit: "kg")
                            SliderRow(label: "Spring Constant (k)", value: $controller.state.springK, range: 5.0...50.0, step: 1.0, unit: "N/m")
                        }
                        
                        // Play/Pause
                        HStack {
                            Spacer()
                            PlayPauseButton(isPlaying: Binding(
                                get: { controller.state.isPlaying },
                                set: { _ in controller.togglePlayPause() }
                            ))
                            Spacer()
                        }
                    }
                }
            }
            .padding(AppDimensions.screenPadding)
        }
        .navigationTitle("Harmonic Motion")
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
        SHMView()
    }
}
