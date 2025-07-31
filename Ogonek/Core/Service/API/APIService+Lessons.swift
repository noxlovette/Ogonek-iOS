//
//  APIService+Lessons.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
        /// Fetch lessons with pagination
    public func fetchLessons(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil) async throws -> PaginatedLessons {
        return try await openAPIClient.fetchLessons(page: page, perPage: perPage, search: search, assignee: assignee)
    }

        /// Create a new lesson
    public func createLesson() async throws -> CreationID {
        return try await openAPIClient.createLesson()
    }

        /// Fetch a specific lesson by ID
    public func fetchLesson(id: String) async throws -> Lesson {
        return try await openAPIClient.fetchLesson(id: id)
    }

        /// Delete a lesson
    public func deleteLesson(id: String) async throws {
        try await openAPIClient.deleteLesson(id: id)
    }

}
