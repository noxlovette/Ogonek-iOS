import SwiftUI
import Foundation

@Observable
class NavigationManager {
    static let shared = NavigationManager()

        // Navigation state
    var selectedTab: Int = 0
    var taskToShow: String?
    var lessonToShow: String?
    var deckToShow: String?
    var shouldShowLearn: Bool = false

    private init() {
            // Listen for notification taps
        NotificationCenter.default.addObserver(
            forName: NotificationName.notificationTapped,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.handleNotificationTap(notification: notification)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

        /// Handle notification tap and route to appropriate screen
    func handleNotificationTap(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let type = userInfo["type"] as? String else { return }

        switch type {
            case "task_created":
                if let taskId = userInfo["task_id"] as? String {
                    navigateToTask(id: taskId)
                } else {
                    navigateToTab(.tasks)
                }

            case "lesson_created":
                if let lessonId = userInfo["lesson_id"] as? String {
                    navigateToLesson(id: lessonId)
                } else {
                    navigateToTab(.lessons)
                }

            case "deck_created":
                if let deckId = userInfo["deck_id"] as? String {
                    navigateToDeck(id: deckId)
                } else {
                    navigateToTab(.decks)
                }

            case "due_cards":
                navigateToLearn()

            case "task_response":
                if let taskId = userInfo["task_id"] as? String {
                    navigateToTask(id: taskId)
                }

            default:
                print("Unknown notification type: \(type)")
        }
    }

        // MARK: - Navigation Methods

    func navigateToTab(_ tab: AppTab) {
        selectedTab = tab.rawValue
    }

    func navigateToTask(id: String) {
        selectedTab = AppTab.tasks.rawValue
        taskToShow = id
    }

    func navigateToLesson(id: String) {
        selectedTab = AppTab.lessons.rawValue
        lessonToShow = id
    }

    func navigateToDeck(id: String) {
        selectedTab = AppTab.decks.rawValue
        deckToShow = id
    }

    func navigateToLearn() {
        selectedTab = AppTab.home.rawValue
        shouldShowLearn = true
    }

        // Clear navigation state
    func clearPendingNavigation() {
        taskToShow = nil
        lessonToShow = nil
        deckToShow = nil
        shouldShowLearn = false
    }
}

enum AppTab: Int, CaseIterable {
    case home = 0
    case lessons = 1
    case tasks = 2
    case decks = 3

    var title: String {
        switch self {
            case .home: return "Home"
            case .lessons: return "Lessons"
            case .tasks: return "Tasks"
            case .decks: return "Decks"
        }
    }

    var icon: String {
        switch self {
            case .home: return "house"
            case .lessons: return "book.pages"
            case .tasks: return "checklist"
            case .decks: return "list.dash.header.rectangle"
        }
    }
}
