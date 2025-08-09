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

    func updateCardProgress(cardID: String, quality: Int32) async throws {
        let path = Operations.UpdateCardProgress.Input.Path(id: cardID)

        let input =
            Operations.UpdateCardProgress.Input(
                path: path,
                body: .json(.init(quality: quality))
            )

        let response = try await client.updateCardProgress(input)

        switch response {
        case .noContent:
            print("ok")
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func resetDeckProgress() async throws {
        notImplemented()
    }

    func toggleDeckSubscription(id: String, subscribed: Bool) async throws {
        if !subscribed {
            _ = try await client.subscribeToDeck(path: .init(id: id))
        } else {
            _ = try await client.unsubscribeFromDeck(path: .init(id: id))
        }
    }
}
