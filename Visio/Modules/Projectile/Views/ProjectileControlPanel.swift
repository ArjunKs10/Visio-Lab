import SwiftUI

/// Control panel containing analytics and initial parameter sliders.
struct ProjectileControlPanel: View {
    @ObservedObject var controller: ProjectileController
    
    var body: some View {
        SectionCard(title: "Controls & Analytics") {
            VStack(spacing: AppDimensions.itemSpacing) {
                
                // Analytics row
                let analytics = controller.analytics
                HStack {
                    ValueBadge(label: "Height", value: analytics.maxHeight, format: "%.1f m")
                    Spacer()
                    ValueBadge(label: "Range", value: analytics.range, format: "%.1f m")
                    Spacer()
                    ValueBadge(label: "Time", value: analytics.maxFlightTime, format: "%.2f s")
                }
                
                Divider()
                    .padding(.vertical, AppDimensions.tightSpacing)
                
                // Sliders
                SliderRow(
                    label: "Initial Velocity (v₀)",
                    value: Binding(
                        get: { controller.state.v0 },
                        set: {
                            controller.state.v0 = $0
                            controller.handleParameterChange()
                        }
                    ),
                    range: 0...50,
                    step: 1.0,
                    unit: "m/s"
                )
                
                SliderRow(
                    label: "Launch Angle (θ)",
                    value: Binding(
                        get: { controller.state.angleDegrees },
                        set: {
                            controller.state.angleDegrees = $0
                            controller.handleParameterChange()
                        }
                    ),
                    range: 0...90,
                    step: 1.0,
                    unit: "°"
                )
                
                // Play/Pause button
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
}

#Preview {
    ProjectileControlPanel(controller: ProjectileController())
        .padding()
}
