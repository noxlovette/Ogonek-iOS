import Foundation
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
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

        /// Update the app icon badge count (iOS 17+ compatible)
    func updateAppIconBadge(count: Int) {
        Task { @MainActor in
            do {
                try await UNUserNotificationCenter.current().setBadgeCount(count)
                print("📱 App icon badge updated to: \(count)")
            } catch {
                print("❌ Failed to set badge count: \(error)")
            }
        }
    }

        /// Clear the app icon badge
    func clearAppIconBadge() {
        updateAppIconBadge(count: 0)
    }

        // MARK: - Notification Handling

        /// Handle notification tap when app is in background/closed
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo

            // Handle the notification tap
        handleNotificationTap(userInfo: userInfo)

        completionHandler()
    }

        /// Handle notification when app is in foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
            // Show notification even when app is in foreground
        completionHandler([.banner, .sound, .badge])
    }

        /// Handle notification tap routing
    private func handleNotificationTap(userInfo: [AnyHashable: Any]) {
        guard let notificationType = userInfo["type"] as? String else { return }

            // Post notification for the app to handle routing
        NotificationCenter.default.post(
            name: NotificationName.notificationTapped,
            object: nil,
            userInfo: ["type": notificationType, "data": userInfo]
        )
    }
}

    // MARK: - Notification Names
struct NotificationName {
    static let notificationTapped = Notification.Name("notificationTapped")
    static let badgeCountChanged = Notification.Name("badgeCountChanged")
}

class PushTokenStore: ObservableObject {
    static let shared = PushTokenStore()

    @Published var token: String?
    @Published var isAuthorized: Bool = false

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
