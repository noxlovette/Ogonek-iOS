import Foundation
import Observation

@Observable
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
            handleError(error)
        }
    }

    @MainActor
    func getPresignedURLs(for id: String) async -> [URL] {
        do {
            return try await apiService.getPresignedDownloadURLs(for: id)
        } catch {
            handleError(error)
            return []
        }
    }
}
