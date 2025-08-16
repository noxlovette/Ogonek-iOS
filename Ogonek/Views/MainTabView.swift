//
//  MainTabView.swift
//  Ogonek
//
//  Created by Danila Volkov on 16.08.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
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
                        .badge(Int(appState.badges?.unseenLessons ?? 0))
                        .accessibilityLabel("Lessons tab")
                        .accessibilityHint("Shows your lessons")

                    TaskListView()
                        .tabItem {
                            Label("Tasks", systemImage: "checklist")
                        }
                        .tag(2)
                        .badge(Int(appState.badges?.unseenTasks ?? 0))
                        .accessibilityLabel("Tasks tab")
                        .accessibilityHint("Shows your tasks")

                    DeckListView()
                        .tabItem {
                            Label("Decks", systemImage: "list.dash.header.rectangle")
                        }
                        .tag(3)
                        .badge(Int(appState.badges?.unseenDecks ?? 0))
                        .accessibilityLabel("Deck tab")
                        .accessibilityHint("Shows your flashcards")
                }
                .tabViewStyle(.sidebarAdaptable)
                .environmentObject(appState)
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
    MainTabView().environmentObject(AppState())
}
