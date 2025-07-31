//
//  LessonDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class LessonDetailViewModel {
    @MainActor var lesson: Lesson?
    @MainActor var isLoading = false
    @MainActor var errorMessage: String?

    private let apiService = APIService()

    /// Fetch a specific lesson by ID
    @MainActor
    func fetchLesson(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            lesson = try await apiService.fetchLesson(id: id)
        } catch {
            errorMessage = "Failed to load lesson: \(error.localizedDescription)"
            print("Error loading lesson: \(error)")
        }

        isLoading = false
    }
}
