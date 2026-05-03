import SwiftUI

/// Padded card container with title header
struct SectionCard<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDimensions.itemSpacing) {
            Text(title)
                .font(AppFonts.title3Bold)
                .foregroundColor(AppColors.label)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    SectionCard(title: "Values") {
        Text("Content goes here")
    }
    .padding()
}
