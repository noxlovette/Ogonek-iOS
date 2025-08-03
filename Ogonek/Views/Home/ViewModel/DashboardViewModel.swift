//
//  HomeViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class DashboardViewModel {
    var dueTasks: [TaskSmall] = []
    var recentLessons: [LessonSmall] = []
    var recentDecks: [DeckSmall] = []
    var dueCardsCount: Int64 = 0
    var recentActivities: [ActivityLog] = []

    var isLoading = false
    var isRefreshing = false
    var errorMessage: String?

    private let apiService = APIService.shared

    /// Load all dashboard data
    @MainActor
    func loadDashboardData() async {
        isLoading = true
        errorMessage = nil
        print("loading dashboard data...")

        do {
            let dashboardData = try await apiService.fetchDashboard()
            dueTasks = dashboardData.tasks.data
            recentLessons = dashboardData.lessons.data
            recentDecks = dashboardData.decks.data
            if let dueCards = dashboardData.learn.dueCards {
                dueCardsCount = dueCards
            }

            recentActivities = dashboardData.activity
        } catch {
            errorMessage = error.localizedDescription
            logger.error("Error loading dashboard data: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func refreshDashboard() async {
        isRefreshing = true
        await loadDashboardData()
        isRefreshing = false
    }
}
