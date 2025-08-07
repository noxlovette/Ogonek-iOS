import Foundation

extension OpenAPIClient {
    func createDeck(_: Operations.CreateDeck.Input) async throws -> Operations.CreateDeck.Output {
        notImplemented()
    }

    func listDecks(_ page: Int32? = 1, _ perPage: Int32? = 20, _ search: String? = nil) async throws -> PaginatedDecks {
        let input = Operations.ListDecks.Input(query: Operations.ListDecks.Input.Query(
            page: page,
            perPage: perPage,
            search: search,
        ))
        let response = try await client.listDecks(input)

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

    func createDeck() async throws -> CreationID {
        let response = try await client.createDeck()

        switch response {
        case let .ok(createdResponse):
            let body = createdResponse.body
            switch body {
            case let .json(id):
                return id
            }

        case .badRequest:
            throw APIError.serverError(statusCode: 400)

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func deleteDeck(id: String) async throws {
        let input = Operations.DeleteDeck.Input.Path(
            id: id,
        )

        _ = try await client.deleteDeck(path: input)
    }

    func fetchDeck(id: String) async throws -> DeckWithCards {
        let input = Operations.FetchDeck.Input.Path(
            id: id,
        )

        let response = try await client.fetchDeck(path: input)

        switch response {
        case let .ok(okResponse):
            let body = okResponse.body

            switch body {
            case let .json(deck):
                return deck
            }
        case .notFound:
            throw APIError.notFound
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateDeck(_ input: Operations.UpdateDeck.Input) async throws -> Operations.UpdateDeck.Output {
        let response = try await client.updateDeck(input)

        return response
    }
}
