    //
    //  SettingsView.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 16.08.2025.
    //

import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()
    @State private var pushTokenStore = PushTokenStore.shared

    var body: some View {
        NavigationStack {
            List {
                Section("Notifications") {
                    Button {
                        viewModel.requestNotificationPermission()
                    } label: {
                        HStack {
                            Image(systemName: "bell")
                                .foregroundStyle(.blue)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Push Notifications")
                                    .font(.body)
                                Text("Get notified about new assignments and responses")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }

                Section("Account") {
                    Button {
                        viewModel.logout()
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(.red)
                            Text("Sign Out")
                                .foregroundStyle(.red)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("Stay Updated", isPresented: $viewModel.showNotificationExplanation) {
            Button("Enable Notifications") {
                Task {
                        // Just request permission - backend registration happens in AppDelegate
                    await pushTokenStore.requestNotificationPermission()
                }
            }
            Button("Not Now", role: .cancel) { }
        } message: {
            Text("Get notified when your teacher responds to homework requests and when new assignments are available.")
        }
    }
}

#Preview {
    SettingsView()
}
