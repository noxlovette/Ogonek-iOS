//
//  APIService+Learn.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    func subscribeToDeck() async throws {
        try await openAPIClient.subscribeToDeck()
    }

    func unsubscribeFromDeck() async throws {
        try await openAPIClient.unsubscribeFromDeck()
    }

    func fetchDueCards() async throws -> [CardProgress] {
        try await openAPIClient.fetchDueCards()
    }

    func updateProgress() async throws {
        try await openAPIClient.updateCardProgress()
    }
}
