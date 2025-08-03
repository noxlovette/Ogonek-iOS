//
//  LessonDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@Observable
class LessonDetailViewModel {
    var lesson: Lesson?
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    /// Fetch a specific lesson by ID
    @MainActor
    func fetchLesson(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            if id == "mock" {
                lesson = MockData.lesson1
            } else {
                lesson = try await apiService.fetchLesson(id: id)
            }
        } catch {
            errorMessage = "Failed to load lesson: \(error.localizedDescription)"
            print("Error loading lesson: \(error)")
        }

        isLoading = false
    }
}
