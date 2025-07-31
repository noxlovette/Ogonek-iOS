//
//  AppState.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation
import Observation

@Observable
class AppState {
    // MARK: - Properties

    var lessons: [LessonSmall] = []
    var isLoading = false
    var errorMessage: String?
    var page: Int32 = 1
    var perPage: Int32 = 10
    var search: String = ""

    // MARK: - Dependencies

    private let apiClient: OpenAPIClient

    // MARK: - Initialization

    init(apiClient: OpenAPIClient = OpenAPIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - API Methods

    /// Load lessons from the API
    @MainActor
    func loadLessons() async throws -> [LessonSmall] {
        isLoading = true

        let paginated = try await apiClient.fetchLessons(
            page: page,
            perPage: perPage,
            search: search,
            assignee: nil
        )

        return paginated.data
    }

    /// Get a specific lesson (for detail view)
    func fetchLesson(id: String) async throws -> Lesson {
        return try await apiClient.fetchLesson(id: id)
    }
}

// MARK: - Global AppState Instance

extension AppState {
    static let shared = AppState()
}

// Make sure LessonSmall conforms to Identifiable for SwiftUI List
extension LessonSmall: Identifiable {
    // The id property should already exist from your OpenAPI schema
}

// Add Equatable conformance if needed for UI updates
extension LessonSmall: Equatable {
    public static func == (lhs: LessonSmall, rhs: LessonSmall) -> Bool {
        return lhs.id == rhs.id
    }
}
