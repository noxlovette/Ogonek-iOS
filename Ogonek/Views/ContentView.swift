//  ContentView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(APIService.self) private var apiService
    @Environment(AppState.self) private var appState
    @State private var tokenManager = TokenManager.shared
    @State private var authSetupCompleted = false
    @State private var hasPerformedInitialSetup = false
    var body: some View {
        Group {
            if tokenManager.isAuthenticated, authSetupCompleted {
                MainTabView()
            } else if !tokenManager.isAuthenticated, authSetupCompleted {
                LoginView()
            } else {
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
            if !hasPerformedInitialSetup {
                await setupAuthentication()
                hasPerformedInitialSetup = true
            }
        }
        .tint(.accentColor)
    }

    @MainActor
    private func setupAuthentication() async {
        print("🚀 Setting up authentication...")

        try? await Task.sleep(nanoseconds: 100_000_000)

        if !apiService.isAuthenticated {
            apiService.restoreAuthenticationIfAvailable()
        }

        tokenManager.isAuthenticated = TokenStorage.hasValidTokens()
        authSetupCompleted = true

        print("✅ Authentication setup completed")
    }
}

#Preview {
    ContentView()
}
