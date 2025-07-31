//
//  APIService+Tasks.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
        /// Fetch Tasks with pagination
    public func fetchTasks(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil, completed: Bool? = false) async throws -> PaginatedTasks {
        return try await openAPIClient.fetchTasks(page: page, perPage: perPage, search: search, assignee: assignee, completed: completed)
    }

        /// Create a new task
    public func createTask() async throws -> CreationID {
        return try await openAPIClient.createTask()
    }

        /// Fetch a specific task by ID
    public func fetchTask(id: String) async throws -> task {
        return try await openAPIClient.fetchTask(id: id)
    }

        /// Delete a task
    public func deleteTask(id: String) async throws {
        try await openAPIClient.deleteTask(id: id)
    }

}
