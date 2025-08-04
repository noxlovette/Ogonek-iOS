//
//  OpenAPIClient+Learn.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension OpenAPIClient {
    func fetchDueCards() async throws -> [CardProgress] {
        let response = try await client.fetchDueCards()

        switch response {
        case let .ok(okResponse):
            switch okResponse.body {
            case let .json(decks):
                return decks
            }

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateCardProgress() async throws {
        notImplemented()
    }

    func resetDeckProgress() async throws {
        notImplemented()
    }

    func subscribeToDeck() async throws {
        notImplemented()
    }

    func unsubscribeFromDeck() async throws {
        notImplemented()
    }
}
