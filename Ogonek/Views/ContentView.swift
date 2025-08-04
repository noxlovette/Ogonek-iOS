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

    var body: some View {
        Group {
            if tokenManager.isAuthenticated {
                authenticatedView
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Try to restore authentication on app launch
            apiService.restoreAuthenticationIfAvailable()

            // Update token manager state based on stored tokens
            tokenManager.isAuthenticated = TokenStorage.hasValidTokens()
        }
        .tint(.accentColour)
    }

    private var authenticatedView: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)

                LessonListView()
                    .tabItem {
                        Label("Lessons", systemImage: "book.pages")
                    }
                    .tag(1)

                TaskListView()
                    .tabItem {
                        Label("Tasks", systemImage: "checklist")
                    }
                    .tag(2)

                DeckGridView()
                    .tabItem {
                        Label("Learn", systemImage: "graduationcap")
                    }
                    .tag(3)
            }
            .tabViewStyle(.sidebarAdaptable)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(APIService.shared)
}
