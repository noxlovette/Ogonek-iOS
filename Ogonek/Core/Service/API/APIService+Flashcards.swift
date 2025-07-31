//
//  APIService+Flashcards.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public extension APIService {
    /// Fetch flashcards

    func listDecks() async throws -> [DeckSmall] {
        return try await openAPIClient.listDecks()
    }

    /// Fetch a specific task by ID
    func fetchDeck(id: String) async throws -> Task {
        return try await openAPIClient.fetchDeck(id: id)
    }
}
