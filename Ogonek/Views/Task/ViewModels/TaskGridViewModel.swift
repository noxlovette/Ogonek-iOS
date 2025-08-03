    //  LessonListViewModel.swift
    //  Ogonek
    //
    //

import Foundation
import Observation

@Observable
class TaskGridViewModel {
    var tasks: [TaskSmall] = []
    var isLoading = false
    var errorMessage: String?

    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    private let apiService = APIService.shared

    @MainActor
    func loadTasks() async {
        isLoading = true
        errorMessage = nil

        do {
            let paginatedResponse = try await apiService.listTasks(
                page: currentPage,
                perPage: 20,
                search: searchText.isEmpty ? nil : searchText
            )

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
        print("notify teacher")
    }
}
