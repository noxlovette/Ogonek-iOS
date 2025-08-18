//  LessonListViewModel.swift
//  Ogonek
//
//

import Foundation

@Observable
class LessonListViewModel: BaseViewModel {
    var lessons: [LessonSmall] = []

    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    @MainActor
    func loadLessons() async {
        isLoading = true
        errorMessage = nil

        var paginatedResponse: PaginatedLessons

        do {
            if isPreview {
                paginatedResponse = MockData.paginatedLessons
            } else {
                paginatedResponse = try await apiService.listLessons(
                    page: currentPage,
                    perPage: 20,
                    search: searchText.isEmpty ? nil : searchText,
                    assignee: nil,
                )
            }

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

    @MainActor
    func refreshLessons() async {
        currentPage = 1
        hasMorePages = true
        await loadLessons()
    }

    @MainActor
    func loadMoreLessons() async {
        guard hasMorePages, !isLoading else { return }
        currentPage += 1
        await loadLessons()
    }

    @MainActor
    func searchLessons(query: String) async {
        searchText = query
        currentPage = 1
        hasMorePages = true
        await loadLessons()
    }
}
