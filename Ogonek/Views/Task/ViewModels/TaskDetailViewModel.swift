import Foundation
import Observation

class TaskDetailViewModel: BaseViewModel {
    var taskWithFiles: TaskWithFiles?

    @MainActor
    func fetchTask(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            taskWithFiles = id == "mock" ?
                MockData.taskWithFiles
                : try await apiService.fetchTask(id: id)
        } catch {
            handleError(error)
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
        if (taskWithFiles?.files.isEmpty) != nil {
            throw DownloadError.noPresignedURLs
        }

        return try await apiService.getPresignedDownloadURLs(for: id)
    }
}
