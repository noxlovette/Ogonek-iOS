import SwiftUI

struct MainTabView: View {
    @Bindable private var appState = AppState.shared

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)
            .accessibilityLabel("Home tab")
            .accessibilityHint("Shows your dashboard with tasks and lessons")

            NavigationStack {
                LessonListView()
            }
            .tabItem {
                Label("Lessons", systemImage: "book.pages")
            }
            .tag(1)
            .badge(Int(appState.badges.unseenLessons))
            .accessibilityLabel("Lessons tab")
            .accessibilityHint("Shows your lessons")

            NavigationStack {
                TaskListView()
            }
            .tabItem {
                Label("Tasks", systemImage: "checklist")
            }
            .tag(2)
            .badge(Int(appState.badges.unseenTasks))
            .accessibilityLabel("Tasks tab")
            .accessibilityHint("Shows your tasks")

            NavigationStack {
                DeckListView()
            }
            .tabItem {
                Label("Decks", systemImage: "list.dash.header.rectangle")
            }
            .tag(3)
            .badge(Int(appState.badges.unseenDecks))
            .accessibilityLabel("Deck tab")
            .accessibilityHint("Shows your flashcards")
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView()
}
