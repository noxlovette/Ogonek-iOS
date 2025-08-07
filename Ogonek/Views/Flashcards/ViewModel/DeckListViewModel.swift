//  DeckListViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class DeckListViewModel {
    var decks: [DeckSmall] = []
    var isLoading = false
    var errorMessage: String?

    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    private let apiService = APIService.shared

    @MainActor
    func loadDecks() async {
        isLoading = true
        errorMessage = nil

        do {
            if
                ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
            {
                decks = MockData.decks()
            } else {
                decks = try await apiService.listDecks(
                    page: currentPage,
                    perPage: 20,
                    search: searchText,
                )
            }
        } catch {
            errorMessage = "Failed to load Decks: \(error.localizedDescription)"
            print("Error loading Decks: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func searchDecks(query: String) async {
        searchText = query
        currentPage = 1
        hasMorePages = true
        await loadDecks()
    }

    /// Refresh Decks (reset to first page)
    @MainActor
    func refreshDecks() async {
        currentPage = 1
        hasMorePages = true
        await loadDecks()
    }
}
