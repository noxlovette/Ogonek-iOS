import Foundation

extension OpenAPIClient {
    func fetchContext() async throws -> AppContext {
        let response = try await client.fetchContext()

        switch response {
        case let .ok(okResponse):
            switch okResponse.body {
            case let .json(context):
                return context
            }

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func fetchBadges() async throws -> NotificationBadges {
        let response = try await client.fetchBadges()

        switch response {
        case let .ok(okResponse):
            switch okResponse.body {
            case let .json(badges):
                return badges
            }

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func fetchDashboard() async throws -> DashboardData {
        let response = try await client.fetchDashboard()

        print(response)

        switch response {
        case let .ok(okResponse):
            print("ok response")
            let body = okResponse.body

            print(body)

            switch body {
            case let .json(data):
                return data
            }

        case .unauthorized:
            throw APIError.unauthorized

        case let .undocumented(statusCode: statuscode, _):
            throw APIError.serverError(statusCode: statuscode)
        }
    }
}
