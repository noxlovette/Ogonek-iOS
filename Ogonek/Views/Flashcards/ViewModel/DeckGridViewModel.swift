//  DeckGridViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class DeckGridViewModel {
    var decks: [DeckSmall] = []
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    @MainActor
    func loadDecks() async {
        isLoading = true
        errorMessage = nil

        do {
            decks = try await apiService.listDecks()

        } catch {
            errorMessage = "Failed to load Decks: \(error.localizedDescription)"
            print("Error loading Decks: \(error)")
        }

        isLoading = false
    }

    /// Refresh Decks (reset to first page)
    @MainActor
    func refreshDecks() async {
        await loadDecks()
    }
}
