//
//  TaskDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@Observable
class TaskDetailViewModel {
    var task: TaskWithFiles?
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    /// Fetch a specific task by ID
    @MainActor
    func fetchTask(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            if id == "mock" {
                task = MockData.taskWithFiles
            } else {
                task = try await apiService.fetchTask(id: id)
            }
        } catch {
            errorMessage = "Failed to load task: \(error.localizedDescription)"
            print("Error loading task: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func toggleTaskCompletion() async {
        guard let currentTask = task else { return }

        do {
            try await apiService.toggleTaskCompletion(id: currentTask.task.id)
        } catch {
            errorMessage = "Failed to update task: \(error.localizedDescription)"
            print("Error toggling completion: \(error)")
        }
    }
}
