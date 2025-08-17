    //
    //  MainTabView.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 16.08.2025.
    //

import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                    .accessibilityLabel("Home tab")
                    .accessibilityHint("Shows your dashboard with tasks and lessons")

                LessonListView()
                    .tabItem {
                        Label("Lessons", systemImage: "book.pages")
                    }
                    .tag(1)
                    .accessibilityLabel("Lessons tab")
                    .accessibilityHint("Shows your lessons")

                TaskListView()
                    .tabItem {
                        Label("Tasks", systemImage: "checklist")
                    }
                    .tag(2)
                    .accessibilityLabel("Tasks tab")
                    .accessibilityHint("Shows your tasks")

                DeckListView()
                    .tabItem {
                        Label("Decks", systemImage: "list.dash.header.rectangle")
                    }
                    .tag(3)
                    .accessibilityLabel("Deck tab")
                    .accessibilityHint("Shows your flashcards")
            }
            .tabViewStyle(.sidebarAdaptable)
            .environment(appState)
        }
        .task {
            await loadAppData()
        }
    }

    private func loadAppData() async {
        await appState.fetchBadges()
        await appState.fetchContext()
    }

}

#Preview {
    MainTabView().environment(AppState())
}
