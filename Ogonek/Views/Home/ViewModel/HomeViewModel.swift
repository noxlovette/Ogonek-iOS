//
//  HomeViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class HomeViewModel {
    // Dashboard data
    @MainActor var dueTasks: [TaskSmall] = []
    @MainActor var recentLessons: [LessonSmall] = []
    @MainActor var recentDecks: [DeckSmall] = []
    @MainActor var dueCardsCount: Int64 = 0
    @MainActor var recentActivities: [ActivityItem] = []

    // Loading states
    @MainActor var isLoading = false
    @MainActor var isRefreshing = false
    @MainActor var errorMessage: String?

    private let apiService = APIService()

    /// Load all dashboard data
    @MainActor
    func loadDashboardData() async {
        isLoading = true
        errorMessage = nil

        await withTaskGroup(of: Void.self) { group in
            // Load due tasks
            group.addTask {
                await self.loadDueTasks()
            }

            // Load recent lessons
            group.addTask {
                await self.loadRecentLessons()
            }

            // Load due cards count
            group.addTask {
                await self.loadDueCardsCount()
            }

            // Load recent decks
            group.addTask {
                await self.loadRecentDecks()
            }

            // Load recent activities (mock for now)
            group.addTask {
                await self.loadRecentActivities()
            }
        }

        isLoading = false
    }

    /// Refresh all dashboard data
    @MainActor
    func refreshDashboard() async {
        isRefreshing = true
        await loadDashboardData()
        isRefreshing = false
    }

    // MARK: - Private Loading Methods

    @MainActor
    private func loadDueTasks() async {
        do {
            let paginatedTasks = try await apiService.listTasks(
                page: 1,
                perPage: 5,
                search: nil,
                assignee: nil,
                completed: false,
            )
            dueTasks = Array(paginatedTasks.data.prefix(3))
        } catch {
            print("Error loading due tasks: \(error)")
            if errorMessage == nil {
                errorMessage = "Failed to load some dashboard data"
            }
        }
    }

    @MainActor
    private func loadRecentLessons() async {
        do {
            let paginatedLessons = try await apiService.listLessons(
                page: 1,
                perPage: 3,
                search: nil,
                assignee: nil,
            )
            recentLessons = paginatedLessons.data
        } catch {
            print("Error loading recent lessons: \(error)")
            if errorMessage == nil {
                errorMessage = "Failed to load some dashboard data"
            }
        }
    }

    @MainActor
    private func loadRecentDecks() async {
        do {
            let decks = try await apiService.listDecks()
            recentDecks = Array(decks.prefix(3))
        } catch {
            print("Error loading recent decks: \(error)")
            if errorMessage == nil {
                errorMessage = "Failed to load some dashboard data"
            }
        }
    }

    @MainActor
    private func loadDueCardsCount() async {
        do {
            // This would need to be added to your APIService
            // For now, using a placeholder
            dueCardsCount = 0
        } catch {
            print("Error loading due cards count: \(error)")
        }
    }

    @MainActor
    private func loadRecentActivities() async {
        // Mock activities for now - you'd implement real activity tracking
        recentActivities = [
            ActivityItem(
                id: UUID().uuidString,
                title: "Completed Math Assignment",
                type: .taskCompleted,
                timestamp: Date().addingTimeInterval(-3600),
            ),
            ActivityItem(
                id: UUID().uuidString,
                title: "Added new lesson: Swift Basics",
                type: .lessonAdded,
                timestamp: Date().addingTimeInterval(-7200),
            ),
            ActivityItem(
                id: UUID().uuidString,
                title: "Subscribed to Spanish Deck",
                type: .deckAdded,
                timestamp: Date().addingTimeInterval(-10800),
            ),
        ]
    }
}
