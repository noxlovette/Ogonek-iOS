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
    var taskWithFiles: TaskWithFiles = .placeholder
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    @MainActor
    func fetchTask(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            taskWithFiles = id == "mock" ?
                MockData.taskWithFiles
                : try await apiService.fetchTask(id: id)
        } catch {
            errorMessage = "Failed to load task: \(error.localizedDescription)"
            print("Error loading task: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func toggleTaskCompletion(id: String) async {
        do {
            try await apiService.toggleTaskCompletion(id: id)
        } catch {
            errorMessage = "Failed to update task: \(error.localizedDescription)"
            print("Error toggling completion: \(error)")
        }
    }

    func getPresignedURLs(for id: String) async throws -> [URL] {
        if taskWithFiles.files.isEmpty {
            throw DownloadError.noPresignedURLs
        }

        if id == "mock" {
            return taskWithFiles.files.map { file in
                URL(string: "https://example.com/mock/\(file.name)")!
            }
        }

        return try await apiService.getPresignedDownloadURLs(for: id)
    }
}
