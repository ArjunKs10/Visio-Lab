import SwiftUI

/// Manages cross-tab navigation and programmatic routing.
final class NavigationRouter: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var pendingTopic: TopicID? = nil
}
