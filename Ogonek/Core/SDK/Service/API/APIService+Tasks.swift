//
//  APIService+Tasks.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    /// Fetch Tasks with pagination
    func listTasks(
        page: Int32? = nil,
        perPage: Int32? = nil,
        search: String? = nil,
        assignee: String? = nil,
        completed: Bool? = false,
    ) async throws -> PaginatedTasks {
        try await openAPIClient.fetchTasks(
            page: page,
            perPage: perPage,
            search: search,
            assignee: assignee,
            completed: completed,
        )
    }

    /// Fetch a specific task by ID
    func fetchTask(id: String) async throws -> TaskWithFiles {
        try await openAPIClient.fetchTask(id: id)
    }

    func requestMoreTasks() async throws {
        try await openAPIClient.requestMoreTasks()
    }

    func toggleTaskCompletion(id: String) async throws {
        try await openAPIClient.toggleTask(id: id)
    }
}
