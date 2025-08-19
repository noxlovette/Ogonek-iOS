//
//  DeckDetailViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation

@Observable
class DeckDetailViewModel: BaseViewModel {
    var deck: DeckWithCards?

    @MainActor
    func fetchDeck(id: String) async {
        isLoading = true
        errorMessage = nil

        if id == "mock" {
            deck = MockData.deck
        } else {
            do {
                deck = try await apiService.fetchDeck(id: id)
            } catch {
                handleError(error)
            }
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
            try await apiService.toggleDeckSubscription(
                id: deckOk.deck.id,
                subscribed: deckOk.deck.isSubscribed ?? false
            )
        } catch {
            handleError(error)
        }
    }
}
