//
//  APIService+Learn.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    func fetchDueCards() async throws -> [CardProgress] {
        try await openAPIClient.fetchDueCards()
    }

    func updateProgress(cardID: String, quality: Int32) async throws {
        try await openAPIClient.updateCardProgress(cardID: cardID, quality: quality)
    }
}
