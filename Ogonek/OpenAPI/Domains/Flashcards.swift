import Foundation

extension OpenAPIClient {

    func listDecks(_ input: Operations.ListDecks.Input) async throws -> Operations.ListDecks.Output {
        notImplemented()
    }

   func createDeck(_ input: Operations.CreateDeck.Input) async throws -> Operations.CreateDeck.Output {
        notImplemented()
    }
    
    func listDecks() async throws -> PaginatedDecks {

        let response = try await self.client.listDecks()

        switch response {
            case .ok(let okResponse):

            switch okResponse.body {
                        case .json(let decks):
                    return decks
                }
            case .unauthorized:
                throw APIError.unauthorized

            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)

        }
    }

    func createDeck() async throws -> CreationID {

        let response = try await client.createDeck()

        switch response {
            case .created(let createdResponse):
                let body = createdResponse.body
                switch body {
                    case .json(let id):
                        return id
                }

            case .badRequest:
                throw APIError.serverError(statusCode: 400)

            case .unauthorized:
                throw APIError.unauthorized

            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func deleteDeck(id: String) async throws {
        let input = Operations.DeleteDeck.Input.Path(
            id: id
        )

        _ = try await client.deleteDeck(path: input)
    }

    func fetchDeck(id: String) async throws -> DeckWithCards {

        let input = Operations.FetchDeck.Input.Path(
            id: id
        )
        
        let response = try await self.client.fetchDeck(path: input)

        switch response {
                case .ok(let okResponse):
                let body = okResponse.body

                switch body {
                case .json(let Deck):
                    return Deck
                }
            case .notFound:
                throw APIError.notFound
            case .unauthorized:
                throw APIError.unauthorized
            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateDeck(_ input: Operations.UpdateDeck.Input) async throws -> Operations.UpdateDeck.Output {
        let response = try await client.updateDeck(input)

        return response
   }
}
