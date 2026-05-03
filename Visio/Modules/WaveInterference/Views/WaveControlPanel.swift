import SwiftUI

/// Sliders to modify wavelength and source separation
struct WaveControlPanel: View {
    @ObservedObject var controller: WaveController
    
    var body: some View {
        SectionCard(title: "Parameters") {
            VStack(spacing: AppDimensions.itemSpacing) {
                
                SliderRow(
                    label: "Wavelength (λ)",
                    value: Binding(
                        get: { controller.state.wavelength },
                        set: { controller.updateWavelength($0) }
                    ),
                    range: 0.5...5.0,
                    step: 0.1,
                    unit: "m"
                )
                
                SliderRow(
                    label: "Source Separation",
                    value: Binding(
                        get: { controller.currentSeparation },
                        set: { controller.updateSeparation($0) }
                    ),
                    range: 1.0...10.0,
                    step: 0.5,
                    unit: "m"
                )
                
                // Legend
                HStack {
                    Spacer()
                    LegendItem(color: AppColors.constructive, label: "Constructive (Max)")
                    Spacer()
                    LegendItem(color: AppColors.destructive, label: "Destructive (Min)")
                    Spacer()
                }
                .padding(.top, 8)
            }
        }
    }
}

fileprivate struct LegendItem: View {
    let color: Color
    let label: String
    
    var body: some View {
        HStack(spacing: AppDimensions.compactSpacing) {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 16, height: 16)
            Text(label)
                .font(AppFonts.caption)
                .foregroundColor(AppColors.secondaryLabel)
        }
    }
}

#Preview {
    WaveControlPanel(controller: WaveController())
        .padding()
}
