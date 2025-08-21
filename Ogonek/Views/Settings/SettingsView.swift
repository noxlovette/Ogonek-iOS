//
//  SettingsView.swift
//  Ogonek
//
//  Created by Danila Volkov on 16.08.2025.
//
import SwiftUI

struct SettingsView: View {
    @State var viewModel = SettingsViewModel()
    @State var pushTokenStore = PushTokenStore.shared
    @State var appState = AppState.shared

    @State var telegramUpdates: Bool = false
    @State private var notifyMeAbout: NotifyMeAbout = NotifyMeAbout()

    struct NotifyMeAbout {
        var taskUpdates: Bool = true
        var lessonUpdates: Bool = true
        var deckUpdates: Bool = true
    }

    var body: some View {
        NavigationStack {
            List {

            notificationSection
            accountSection

                    Button {
                        viewModel.logout()
                    } label: {
                        Text("Sign Out")
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.plain)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await checkNotificationStatus()
                await appState.fetchContext()
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
            Text("Get task, lesson, and deck updates. You can turn this off in your device's settings later.")
        }
    }

    private func checkNotificationStatus() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        await MainActor.run {
            pushTokenStore.isAuthorized = settings.authorizationStatus == .authorized
        }
    }

    func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}


#Preview {
    SettingsView()
}
