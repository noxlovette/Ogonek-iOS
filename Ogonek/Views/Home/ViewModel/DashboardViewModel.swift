//
//  DashboardViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class DashboardViewModel: BaseViewModel {
    var dueTasks: [TaskSmall] = []
    var recentLessons: [LessonSmall] = []
    var dueCardsCount: Int64 = 0
    var recentActivities: [ActivityLog] = []

    var isRefreshing = false

    @MainActor
    func loadDashboardData() async {
        isLoading = true
        errorMessage = nil
        do {
            if isPreview {
                dueTasks = MockData.tasks.data
                recentLessons = MockData.paginatedLessons.data
                dueCardsCount = 0
                recentActivities = []
            } else {
                let dashboardData = try await apiService.fetchDashboard()
                dueTasks = dashboardData.tasks
                recentLessons = dashboardData.lessons
                recentActivities = dashboardData.activity
            }
        } catch {
            handleError(error)
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
