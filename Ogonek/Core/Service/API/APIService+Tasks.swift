//
//  APIService+Tasks.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public extension APIService {
    /// Fetch Tasks with pagination
    func listTasks(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil, completed: Bool? = false) async throws -> PaginatedTasks {
        return try await openAPIClient.fetchTasks(page: page, perPage: perPage, search: search, assignee: assignee, completed: completed)
    }

    /// Fetch a specific task by ID
    func fetchTask(id: String) async throws -> Task {
        return try await openAPIClient.fetchTask(id: id)
    }
}
