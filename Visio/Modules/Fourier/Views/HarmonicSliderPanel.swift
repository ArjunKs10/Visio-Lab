import SwiftUI

/// Control panel to choose target wave and number of harmonics.
struct HarmonicSliderPanel: View {
    @ObservedObject var controller: FourierController
    
    var body: some View {
        SectionCard(title: "Parameters") {
            VStack(spacing: AppDimensions.itemSpacing) {
                
                Picker("Target Shape", selection: Binding(
                    get: { controller.state.shape },
                    set: {
                        controller.state.shape = $0
                        controller.handleParameterChange()
                    }
                )) {
                    ForEach(TargetShape.allCases) { shape in
                        Text(shape.rawValue).tag(shape)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, AppDimensions.tightSpacing)
                
                SliderRow(
                    label: "Number of Harmonics (N)",
                    value: Binding(
                        get: { Double(controller.state.harmonicCount) },
                        set: {
                            controller.state.harmonicCount = Int($0)
                            controller.handleParameterChange()
                        }
                    ),
                    range: 1...50,
                    step: 1,
                    unit: ""
                )
                
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
    HarmonicSliderPanel(controller: FourierController())
        .padding()
}
