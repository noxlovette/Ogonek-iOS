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
    @MainActor var recentActivities: [ActivityLog] = []

    // Loading states
    @MainActor var isLoading = false
    @MainActor var isRefreshing = false
    @MainActor var errorMessage: String?

    private let apiService = APIService.shared

    /// Load all dashboard data
    @MainActor
    func loadDashboardData() async {
        isLoading = true
        errorMessage = nil
        print("loading dashboard data...")

        do {
            let dashboardData = try await apiService.fetchDashboard()
            print(dashboardData)
            dueTasks = dashboardData.tasks.data
            recentLessons = dashboardData.lessons.data
            recentDecks = dashboardData.decks.data
            if let dueCards = dashboardData.learn.dueCards {
                dueCardsCount = dueCards
            }

            recentActivities = dashboardData.activity
        } catch {
            logger.error("Error loading dashboard data: \(error)")
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

}
