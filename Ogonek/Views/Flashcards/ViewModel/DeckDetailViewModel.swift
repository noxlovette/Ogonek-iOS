//
//  DeckDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@Observable
class DeckDetailViewModel {
    var deck: DeckWithCards?
    var isLoading = false
    var errorMessage: String?

    private let apiService = APIService.shared

    @MainActor
    func fetchDeck(id: String) async {
        isLoading = true
        errorMessage = nil

        do {
            if id == "mock" {
                deck = MockData.deck
            } else {
                deck = try await apiService.fetchDeck(id: id)
            }
        } catch {
            errorMessage = "Failed to load Deck: \(error.localizedDescription)"
            print("Error loading Deck: \(error)")
        }

        isLoading = false
    }
}
