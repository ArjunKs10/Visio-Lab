import SwiftUI

/// Toggles isPlaying, uses SF Symbols: play.fill / pause.fill
/// Size: 44×44 minimum, accent color foreground
struct PlayPauseButton: View {
    @Binding var isPlaying: Bool

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isPlaying.toggle()
            }
        } label: {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.title)
                .frame(minWidth: AppDimensions.minTapTarget, minHeight: AppDimensions.minTapTarget)
                .foregroundColor(AppColors.mathAccent)
        }
    }
}

#Preview {
    PlayPauseButton(isPlaying: .constant(false))
}
