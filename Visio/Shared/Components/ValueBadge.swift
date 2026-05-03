import SwiftUI

/// Rounded rect pill, label + value side by side
/// Color: green (positive), red (negative), gray (zero)
struct ValueBadge: View {
    let label: String
    let value: String
    let color: Color

    /// Standard initializer
    init(label: String, value: String, color: Color = AppColors.neutral) {
        self.label = label
        self.value = value
        self.color = color
    }
    
    /// Convenience initializer that determines color based on the value's sign
    init(label: String, value: Double, format: String = "%.2f") {
        self.label = label
        self.value = String(format: format, value)
        self.color = Color.forSign(value)
    }

    var body: some View {
        HStack(spacing: AppDimensions.compactSpacing) {
            Text(label)
                .font(AppFonts.caption)
            Text(value)
                .font(AppFonts.bodySemibold)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color.opacity(0.15))
        .foregroundColor(color)
        .clipShape(Capsule())
    }
}

#Preview {
    HStack {
        ValueBadge(label: "sin", value: 0.50)
        ValueBadge(label: "cos", value: -0.86)
        ValueBadge(label: "tan", value: 0.0)
    }
}
