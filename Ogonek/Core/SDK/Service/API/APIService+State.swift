//
//  APIService+State.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    /// Fetch Badges
    func fetchBadges() async throws -> NotificationBadges {
        return try await openAPIClient.fetchBadges()
    }

    func fetchDashboard() async throws -> DashboardData {
        return try await openAPIClient.fetchDashboard()
    }

    func fetchContext() async throws -> AppContext {
        return try await openAPIClient.fetchContext()
    }
}
