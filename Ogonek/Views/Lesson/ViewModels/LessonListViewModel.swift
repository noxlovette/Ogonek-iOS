//  LessonListViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class LessonListViewModel {
    var lessons: [LessonSmall] = []
    var isLoading = false
    var errorMessage: String?

    // Pagination properties
    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    private let apiService = APIService.shared

    /// Load lessons from the API
    @MainActor
    func loadLessons() async {
        isLoading = true
        errorMessage = nil

        do {
            let paginatedResponse = try await apiService.listLessons(
                page: currentPage,
                perPage: 20,
                search: searchText.isEmpty ? nil : searchText,
                assignee: nil,
            )

            if currentPage == 1 {
                lessons = paginatedResponse.data
            } else {
                lessons.append(contentsOf: paginatedResponse.data)
            }

            hasMorePages = paginatedResponse.data.count >= 20

        } catch {
            errorMessage = "Failed to load lessons: \(error.localizedDescription)"
            print("Error loading lessons: \(error)")
        }

        isLoading = false
    }

    /// Refresh lessons (reset to first page)
    @MainActor
    func refreshLessons() async {
        currentPage = 1
        hasMorePages = true
        await loadLessons()
    }

    /// Load more lessons (pagination)
    @MainActor
    func loadMoreLessons() async {
        guard hasMorePages, !isLoading else { return }
        currentPage += 1
        await loadLessons()
    }

    /// Search for lessons
    @MainActor
    func searchLessons(query: String) async {
        searchText = query
        currentPage = 1
        hasMorePages = true
        await loadLessons()
    }
}
