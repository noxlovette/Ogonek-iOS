//
//  DeckDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@Observable
class DeckDetailViewModel: ObservableObject {
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

    @MainActor
    func toggleSubscription() async {
        guard let deckOk = deck else {
            errorMessage = "No deck available"
            return
        }
        isLoading = true
        errorMessage = nil

        do {
            try await apiService.toggleDeckSubscription(id: deckOk.deck.id, subscribed: deckOk.deck.isSubscribed ?? false)
        } catch {
            errorMessage = "Failed to toggle subscription: \(error.localizedDescription)"
            print("Error toggling subscription: \(error)")
        }
    }

    @MainActor var hasError: Bool {
        get { errorMessage != nil }
        set { if !newValue { errorMessage = nil } }
    }
}
