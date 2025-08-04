import Foundation

extension OpenAPIClient {
    func fetchLessons(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil) async throws -> PaginatedLessons {
        let input = Operations.ListLessons.Input(
            query: Operations.ListLessons.Input.Query(
                page: page,
                perPage: perPage,
                search: search,
                assignee: assignee,
            ),
        )

        let response = try await client.listLessons(input)

        switch response {
        case let .ok(okResponse):
            let body = okResponse.body
            switch body {
            case let .json(paginatedResponse):
                return paginatedResponse
            }

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func createLesson() async throws -> CreationID {
        let response = try await client.createLesson()

        switch response {
        case let .created(createdResponse):
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

    func deleteLesson(id: String) async throws {
        let input = Operations.DeleteLesson.Input.Path(
            id: id,
        )

        _ = try await client.deleteLesson(path: input)
    }

    func fetchLesson(id: String) async throws -> Lesson {
        let input = Operations.FetchLesson.Input.Path(
            id: id,
        )

        let response = try await client.fetchLesson(path: input)

        switch response {
        case let .ok(okResponse):
            let body = okResponse.body

            switch body {
            case let .json(lesson):
                return lesson
            }
        case .notFound:
            throw APIError.notFound
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateLesson(_ input: Operations.UpdateLesson.Input) async throws -> Operations.UpdateLesson.Output {
        let response = try await client.updateLesson(input)

        return response
    }
}
