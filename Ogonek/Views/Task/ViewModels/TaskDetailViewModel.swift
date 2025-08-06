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
    let taskID: String
    var taskWithFiles: TaskWithFiles?
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    init(taskID: String = "mock") {
        self.taskID = taskID
    }

    @MainActor
    func fetchTask() async {
        isLoading = true
        errorMessage = nil

        do {
            if taskID == "mock" {
                taskWithFiles = MockData.taskWithFiles
            } else {
                taskWithFiles = try await apiService.fetchTask(id: taskID)
            }
        } catch {
            errorMessage = "Failed to load task: \(error.localizedDescription)"
            print("Error loading task: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func toggleTaskCompletion() async {
        do {
            try await apiService.toggleTaskCompletion(id: taskID)
        } catch {
            errorMessage = "Failed to update task: \(error.localizedDescription)"
            print("Error toggling completion: \(error)")
        }
    }
}
