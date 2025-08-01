//
//  APIService+Tasks.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    func fetchDashboard() async throws -> DashboardData {
        return try await openAPIClient.fetchDashboard()
    }
}
