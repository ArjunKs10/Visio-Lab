import SwiftUI

/// Control panel for the Unit Circle module.
/// Displays an angle slider and live value badges for sin, cos, and tan.
struct TrigValuesPanel: View {
    @ObservedObject var controller: UnitCircleController
    
    var body: some View {
        SectionCard(title: "Trigonometric Values") {
            VStack(spacing: AppDimensions.itemSpacing) {
                // Angle Slider
                SliderRow(
                    label: "Angle",
                    value: Binding(
                        get: { controller.state.angleDegrees },
                        set: { controller.updateAngle(degrees: $0) }
                    ),
                    range: -360...360,
                    step: 1.0,
                    unit: "°"
                )
                
                Divider()
                    .padding(.vertical, AppDimensions.tightSpacing)
                
                // Live Readout Badges
                HStack(spacing: AppDimensions.itemSpacing) {
                    ValueBadge(label: "sin", value: controller.state.sinValue)
                    ValueBadge(label: "cos", value: controller.state.cosValue)
                    
                    if controller.state.tanValue.isInfinite {
                        ValueBadge(label: "tan", value: "∞", color: AppColors.warning)
                    } else {
                        ValueBadge(label: "tan", value: controller.state.tanValue)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TrigValuesPanel(controller: UnitCircleController())
        .padding()
}
