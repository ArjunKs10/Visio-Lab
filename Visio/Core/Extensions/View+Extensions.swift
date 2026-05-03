import SwiftUI

/// Reusable view modifiers for consistent styling across the app
extension View {

    // MARK: - Card Styles

    /// Standard card style — used by SectionCard, TopicCard, and control panels
    /// Rounded rect with secondary background, subtle shadow, standard padding
    func cardStyle() -> some View {
        self
            .padding(AppDimensions.cardPadding)
            .background(AppColors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: AppDimensions.cardShadowRadius, x: 0, y: 1)
    }

    /// Canvas area style — for the drawing/visualization area
    func canvasStyle() -> some View {
        self
            .background(AppColors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppDimensions.cardCornerRadius, style: .continuous))
    }

    // MARK: - Layout Helpers

    /// Apply the standard canvas height (square aspect ratio)
    /// Prevents GeometryReader from collapsing inside ScrollViews.
    func canvasFrame() -> some View {
        self.aspectRatio(1.0, contentMode: .fit)
    }

    /// Ensure minimum tap target size (44×44)
    func minTapTarget() -> some View {
        self
            .frame(minWidth: AppDimensions.minTapTarget, minHeight: AppDimensions.minTapTarget)
    }

    // MARK: - Typography Shortcuts

    /// Apply rounded headline font
    func headlineRounded() -> some View {
        self.font(AppFonts.headline)
    }

    /// Apply rounded caption font with secondary color
    func captionSecondary() -> some View {
        self
            .font(AppFonts.caption)
            .foregroundStyle(AppColors.secondaryLabel)
    }

    // MARK: - Conditional Modifiers

    /// Apply a modifier conditionally
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
