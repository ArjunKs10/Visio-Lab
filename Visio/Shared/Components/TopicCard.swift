import SwiftUI

/// Topic category: Math or Physics
enum TopicCategory: String {
    case math = "Math"
    case physics = "Physics"

    var accentColor: Color {
        switch self {
        case .math: return AppColors.mathAccent
        case .physics: return AppColors.physicsAccent
        }
    }
    
    var tagBackground: Color {
        switch self {
        case .math: return AppColors.mathTagBackground
        case .physics: return AppColors.physicsTagBackground
        }
    }
}

/// Topic item data for HomeView grid
struct TopicItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let sfSymbol: String
    let category: TopicCategory
}

/// SF Symbol icon + topic name + one-line description + category tag
/// Tappable, navigates to module view
struct TopicCard: View {
    let topic: TopicItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: AppDimensions.itemSpacing) {
                Image(systemName: topic.sfSymbol)
                    .font(AppFonts.title)
                    .foregroundColor(topic.category.accentColor)
                    .padding(.bottom, 4)
                
                Text(topic.name)
                    .font(AppFonts.headlineBold)
                    .foregroundColor(AppColors.label)
                    .lineLimit(1)
                
                Text(topic.description)
                    .font(AppFonts.caption)
                    .foregroundColor(AppColors.secondaryLabel)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    
                Spacer(minLength: 8)
                
                HStack {
                    Spacer()
                    Text(topic.category.rawValue)
                        .font(AppFonts.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(topic.category.tagBackground)
                        .foregroundColor(topic.category.accentColor)
                        .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TopicCard(
        topic: TopicItem(
            name: "Unit Circle",
            description: "Explore sin, cos, and tan visually",
            sfSymbol: "circle.dotted",
            category: .math
        ),
        action: {}
    )
    .frame(width: 180, height: 180)
    .padding()
}
