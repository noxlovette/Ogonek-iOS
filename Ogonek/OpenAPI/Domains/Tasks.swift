import Foundation

extension OpenAPIClient {
    func fetchTasks(page: Int32? = nil, perPage: Int32? = nil, search: String? = nil, assignee: String? = nil, completed: Bool? = false) async throws -> PaginatedTasks {

        let input = Operations.ListTasks.Input(
            query: Operations.ListTasks.Input.Query(
                page: page,
                perPage: perPage,
                search: search,
                assignee: assignee,
                completed: false,
            )
        )

        let response = try await self.client.listTasks(input)

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

    func createTask() async throws -> CreationID {

        let response = try await client.createTask()

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

    func deleteTask(id: String) async throws {
        let input = Operations.DeleteTask.Input.Path(
            id: id
        )

        _ = try await client.deleteTask(path: input)
    }

    func fetchTask(id: String) async throws -> Task {

        let input = Operations.FetchTask.Input.Path(
            id: id
        )
        
        let response = try await self.client.fetchTask(path: input)

        switch response {
                case .ok(let okResponse):
                let body = okResponse.body

                switch body {
                case .json(let task):
                    return task

                
                }
            case .notFound:
                throw APIError.notFound
            case .unauthorized:
                throw APIError.unauthorized
            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func updateTask(_ input: Operations.UpdateTask.Input) async throws -> Operations.UpdateTask.Output {
        let response = try await client.updateTask(input)

        return response
   }
}
