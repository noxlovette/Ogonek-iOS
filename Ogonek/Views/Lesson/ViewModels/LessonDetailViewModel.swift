//
//  LessonDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

class LessonDetailViewModel: BaseViewModel {
    var lesson: Lesson?

    @MainActor
    func fetchLesson(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            lesson = id == "mock" ? MockData.lesson1 : try await apiService.fetchLesson(id: id)
        } catch {
            handleError(error)
        }

        isLoading = false
    }
}
