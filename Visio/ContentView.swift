import SwiftUI

struct ContentView: View {
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            // Tab 1: Learn
            NavigationStack {
                LessonsHomeView()
            }
            .tabItem {
                Label("Learn", systemImage: "book.fill")
            }
            .tag(0)
            
            // Tab 2: Visualise
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Visualise", systemImage: "waveform.path.ecg")
            }
            .tag(1)
        }
        .tabViewStyle(.automatic)
        .tint(AppColors.mathAccent)
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
