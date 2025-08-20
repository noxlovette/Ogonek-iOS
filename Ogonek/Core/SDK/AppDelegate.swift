import Foundation
import SwiftUI
import UserNotifications

@Observable
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var selectedTab: Int = 0

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func application(
        _: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs Token: \(token)")
        PushTokenStore.shared.token = token
        Task {
            await PushTokenStore.shared.registerWithBackend()
        }
    }

    func application(
        _: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register for remote notifications: \(error)")
    }

    // MARK: - Badge Management

    func updateAppIconBadge(count: Int) {
        Task { @MainActor in
            do {
                try await UNUserNotificationCenter.current().setBadgeCount(count)
                print("📱 Badge: \(count)")
            } catch {
                print("❌ Badge failed")
            }
        }
    }

    // MARK: - Notification Handling

    func userNotificationCenter(
        _: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo

        // Extract type from your payload structure
        guard let customData = userInfo["data"] as? [String: Any],
              let type = customData["type"] as? String
        else {
            completionHandler()
            return
        }

        DispatchQueue.main.async {
            switch type {
            case "task_created", "task_updated", "task_response":
                AppState.shared.selectedTab = 2 // Tasks
            case "lesson_created":
                AppState.shared.selectedTab = 1 // Lessons
            case "deck_created":
                AppState.shared.selectedTab = 3 // Decks
            case "cards_due":
                AppState.shared.selectedTab = 0 // Home
            default:
                AppState.shared.selectedTab = 0
            }
            print("🎯 Opened tab: \(AppState.shared.selectedTab)")
        }

        completionHandler()
    }

    func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent _: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge])
    }
}

@Observable
class PushTokenStore {
    static let shared = PushTokenStore()

    var token: String?
    var isAuthorized: Bool = false

    private init() {}

    func requestNotificationPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            )

            await MainActor.run {
                self.isAuthorized = granted
            }

            if granted {
                await MainActor.run {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }

            return granted
        } catch {
            print("Failed to request notification permission: \(error)")
            return false
        }
    }

    func registerWithBackend() async {
        guard let token = token, isAuthorized else { return }

        do {
            try await APIService.shared.registerDevice(token)
        } catch {
            print("failed to register device: \(error)")
        }
    }
}
