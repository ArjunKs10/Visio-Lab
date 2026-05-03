import SwiftUI

/// Generic slider row with label, formatted value, and slider
/// Label (left) + formatted value (right) + Slider (middle)
/// Small min/max labels below in gray
struct SliderRow<V: BinaryFloatingPoint>: View where V.Stride: BinaryFloatingPoint {
    let label: String
    @Binding var value: V
    let range: ClosedRange<V>
    var step: V.Stride
    var unit: String?

    init(label: String, value: Binding<V>, range: ClosedRange<V>, step: V.Stride, unit: String? = nil) {
        self.label = label
        self._value = value
        self.range = range
        self.step = step
        self.unit = unit
    }

    var body: some View {
        VStack(spacing: AppDimensions.tightSpacing) {
            HStack {
                Text(label)
                    .font(AppFonts.callout)
                    .foregroundColor(AppColors.label)
                Spacer()
                Text(formattedValue)
                    .font(AppFonts.calloutSemibold)
                    .foregroundColor(AppColors.label)
            }
            
            Slider(value: $value, in: range, step: step)
                .tint(AppColors.mathAccent)
            
            HStack {
                Text(formatValue(range.lowerBound))
                Spacer()
                Text(formatValue(range.upperBound))
            }
            .font(AppFonts.footnote)
            .foregroundColor(AppColors.secondaryLabel)
        }
    }

    private var formattedValue: String {
        let formatted = formatValue(value)
        if let unit = unit {
            return "\(formatted) \(unit)"
        }
        return formatted
    }
    
    private func formatValue(_ val: V) -> String {
        let doubleVal = Double(val)
        let doubleStep = Double(step)
        if doubleStep.truncatingRemainder(dividingBy: 1.0) == 0 {
            return String(format: "%.0f", doubleVal)
        } else if doubleStep >= 0.1 {
            return String(format: "%.1f", doubleVal)
        } else {
            return String(format: "%.2f", doubleVal)
        }
    }
}

#Preview {
    VStack {
        SliderRow(label: "Velocity", value: .constant(15.0), range: 0...100, step: 1.0, unit: "m/s")
        SliderRow(label: "Angle", value: .constant(45.5), range: 0...90, step: 0.1, unit: "°")
    }
    .padding()
}
