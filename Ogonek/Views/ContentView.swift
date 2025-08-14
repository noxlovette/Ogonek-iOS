//
//  ContentView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apiService: APIService
    @StateObject private var tokenManager = TokenManager.shared
    @State private var selectedTab = 0
    @State private var authSetupCompleted = false

    var body: some View {
        Group {
            if tokenManager.isAuthenticated, authSetupCompleted {
                authenticatedView
            } else if !tokenManager.isAuthenticated, authSetupCompleted {
                LoginView()
            } else {
                // Show loading while setting up authentication
                VStack {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Loading...")
                        .padding(.top, 16)
                        .foregroundColor(.secondary)
                }
            }
        }
        .task {
            await setupAuthentication()
        }
        .tint(.accentColor)
    }

    @MainActor
    private func setupAuthentication() async {
        // Give the system a moment to settle
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        // Try to restore authentication on app launch
        apiService.restoreAuthenticationIfAvailable()

        // Update token manager state based on stored tokens
        tokenManager.isAuthenticated = TokenStorage.hasValidTokens()

        // Mark auth setup as completed
        authSetupCompleted = true

        print("🚀 Authentication setup completed. Authenticated: \(tokenManager.isAuthenticated)")
    }

    private var authenticatedView: some View {
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
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(APIService.shared)
}
