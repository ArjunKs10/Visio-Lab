import SwiftUI

/// Calls controller.reset(), uses SF Symbol: arrow.counterclockwise
/// Placed in .toolbar { ToolbarItem(placement: .navigationBarTrailing) }
struct ResetButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Image(systemName: "arrow.counterclockwise")
                .font(.body)
                .frame(minWidth: AppDimensions.minTapTarget, minHeight: AppDimensions.minTapTarget)
                .foregroundColor(AppColors.mathAccent)
        }
    }
}

#Preview {
    ResetButton(action: {})
}
