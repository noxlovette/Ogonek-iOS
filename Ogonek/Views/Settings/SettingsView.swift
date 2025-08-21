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
                        if pushTokenStore.isAuthorized {
                            // If already authorized, open Settings app
                            openAppSettings()
                        } else {
                            // If not authorized, request permission
                            viewModel.requestNotificationPermission()
                        }
                    } label: {
                        HStack {
                            Image(systemName: pushTokenStore.isAuthorized ? "bell.fill" : "bell.slash")
                                .foregroundStyle(pushTokenStore.isAuthorized ? .green : .gray)

                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text("Push Notifications")
                                        .font(.body)

                                    Spacer()

                                    Text(pushTokenStore.isAuthorized ? "Enabled" : "Disabled")
                                        .font(.caption)
                                        .foregroundStyle(pushTokenStore.isAuthorized ? .green : .secondary)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(
                                            Capsule()
                                                .fill(pushTokenStore.isAuthorized ? .green.opacity(0.1) : .gray.opacity(0.1))
                                        )
                                }
                            }
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
            .task {
                await checkNotificationStatus()
            }
        }
        .alert("Stay Updated", isPresented: $viewModel.showNotificationExplanation) {
            Button("Enable Notifications") {
                Task {
                    await pushTokenStore.requestNotificationPermission()
                }
            }
            Button("Not Now", role: .cancel) {}
        } message: {
            Text("Get task, lesson, and deck updates.")
        }
    }

    private func checkNotificationStatus() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()

        await MainActor.run {
            pushTokenStore.isAuthorized = settings.authorizationStatus == .authorized
        }
    }

    private func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

#Preview {
    SettingsView()
}
