import Foundation
import SwiftUI

@Observable
class AppState: BaseViewModel {
    static let shared = AppState()

    var badges = NotificationBadges()
    var context: AppContext?

        // Track total unread count for app icon badge
    var totalUnreadCount: Int {
        let dueCards = badges.dueCards ?? 0
        let unseenDecks = badges.unseenDecks
        let unseenLessons = badges.unseenLessons
        let unseenTasks = badges.unseenTasks

        return Int(dueCards + unseenDecks + unseenLessons + unseenTasks)
    }

    @MainActor
    func fetchBadges() async {
        do {
            if isPreview {
                badges = MockData.badges
                print(badges)
                return
            }
            badges = try await apiService.fetchBadges()
            print(badges)

                // Update app icon badge when badges change
            updateAppIconBadge()

        } catch {
            handleError(error)
        }
    }

    @MainActor
    func fetchContext() async {
        do {
            context = try await apiService.fetchContext()
        } catch {
            handleError(error)
        }
    }

        /// Update the app icon badge count (iOS 17+ compatible)
    @MainActor
    func updateAppIconBadge() {
        let count = totalUnreadCount
        Task {
            do {
                try await UNUserNotificationCenter.current().setBadgeCount(count)
                print("📱 App icon badge updated to: \(count)")
            } catch {
                print("❌ Failed to set badge count: \(error)")
            }
        }
    }

        /// Clear app icon badge (call when user views content)
    @MainActor
    func clearAppIconBadge() {
        Task {
            do {
                try await UNUserNotificationCenter.current().setBadgeCount(0)
                print("📱 App icon badge cleared")
            } catch {
                print("❌ Failed to clear badge count: \(error)")
            }
        }
    }

        /// Mark specific items as seen and update badge
    @MainActor
    func markItemsAsSeen(type: NotificationItemType, count: Int = 1) {
        switch type {
            case .tasks:
                badges.unseenTasks = max(0, badges.unseenTasks - Int64(count))
            case .lessons:
                badges.unseenLessons = max(0, badges.unseenLessons - Int64(count))
            case .decks:
                badges.unseenDecks = max(0, badges.unseenDecks - Int64(count))
            case .dueCards:
                badges.dueCards = max(0, (badges.dueCards ?? 0) - Int64(count))
        }

        updateAppIconBadge()
    }
}

enum NotificationItemType {
    case tasks
    case lessons
    case decks
    case dueCards
}
