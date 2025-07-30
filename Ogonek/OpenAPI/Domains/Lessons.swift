import Foundation

extension OpenAPIClient {
    func fetchLessons(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil) async throws -> PaginatedLessons {

        let input = Operations.ListLessons.Input(
            query: Operations.ListLessons.Input.Query(
                page: page,
                perPage: perPage,
                search: search,
                assignee: assignee
            )
        )

        let response = try await self.client.listLessons(input)

        switch response {
            case .ok(let okResponse):
                let body = okResponse.body
                switch body {
                    case .json(let paginatedResponse):
                        return paginatedResponse
                }

            case .unauthorized:
                throw APIError.unauthorized

            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func createLesson() async throws -> CreationID {

        let response = try await client.createLesson()

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

    func deleteLesson(id: String) async throws {
        let input = Operations.DeleteLesson.Input.Path(
            id: id
        )

        _ = try await client.deleteLesson(path: input)
    }

    func fetchLesson(id: String) async throws -> Lesson {

        let input = Operations.FetchLesson.Input.Path(
            id: id
        )
        
        let response = try await self.client.fetchLesson(path: input)

        switch response {
                case .ok(let okResponse):
                let body = okResponse.body

                switch body {
                case .json(let lesson):
                    return lesson
                    
                
                }
            case .notFound:
                throw APIError.notFound
            case .unauthorized:
                throw APIError.unauthorized
            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateLesson(_ input: Operations.UpdateLesson.Input) async throws -> Operations.UpdateLesson.Output {
        let response = try await client.updateLesson(input)

        return response
   }
}
