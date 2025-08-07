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
    var lesson: Lesson = .placeholder
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    @MainActor
    func fetchLesson(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            lesson = id == "mock" ? MockData.lesson1 : try await apiService.fetchLesson(id: id)
        } catch {
            errorMessage = "Failed to load lesson: \(error.localizedDescription)"
            print("Error loading lesson: \(error)")
        }

        isLoading = false
    }
}
