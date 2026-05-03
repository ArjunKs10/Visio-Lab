import SwiftUI

/// Control panel containing function picker and sliders for a, b, c, d
struct ParameterSliderPanel: View {
    @ObservedObject var controller: FunctionTransformController
    
    var body: some View {
        SectionCard(title: "Parameters") {
            VStack(spacing: AppDimensions.itemSpacing) {
                
                // Function Picker
                Picker("Function", selection: $controller.type) {
                    ForEach(FunctionType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, AppDimensions.tightSpacing)
                
                // Sliders
                SliderRow(
                    label: "a (Vertical Stretch)",
                    value: $controller.params.a,
                    range: -5...5,
                    step: 0.1
                )
                
                SliderRow(
                    label: "b (Horizontal Stretch)",
                    value: $controller.params.b,
                    range: -5...5,
                    step: 0.1
                )
                
                SliderRow(
                    label: "c (Horizontal Shift)",
                    value: $controller.params.c,
                    range: -10...10,
                    step: 0.5
                )
                
                SliderRow(
                    label: "d (Vertical Shift)",
                    value: $controller.params.d,
                    range: -10...10,
                    step: 0.5
                )
            }
        }
    }
}

#Preview {
    ParameterSliderPanel(controller: FunctionTransformController())
        .padding()
}
