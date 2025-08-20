//  TaskListViewModel.swift
//  Ogonek
//

import Foundation

class TaskListViewModel: BaseViewModel {
    var tasks: [TaskSmall] = []

    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    @MainActor
    func loadTasks() async {
        isLoading = true
        errorMessage = nil

        do {
            let paginatedResponse = if isPreview {
                MockData.tasks
            } else {
                try await apiService.listTasks(
                    page: currentPage,
                    perPage: 20,
                    search: searchText.isEmpty ? nil : searchText,
                )
            }

            if currentPage == 1 {
                tasks = paginatedResponse.data
            } else {
                tasks.append(contentsOf: paginatedResponse.data)
            }

            hasMorePages = paginatedResponse.data.count >= 20

        } catch {
            errorMessage = "Failed to load Tasks: \(error.localizedDescription)"
            print("Error loading Tasks: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func refreshTasks() async {
        currentPage = 1
        hasMorePages = true
        await loadTasks()
    }

    @MainActor
    func loadMoreTasks() async {
        guard hasMorePages, !isLoading else { return }
        currentPage += 1
        await loadTasks()
    }

    @MainActor
    func searchTasks(query: String) async {
        searchText = query
        currentPage = 1
        hasMorePages = true
        await loadTasks()
    }

    @MainActor
    func requestMoreTasks() async {
        do {
            try await apiService.requestMoreTasks()
        } catch {
            handleError(error)
        }
    }
}
