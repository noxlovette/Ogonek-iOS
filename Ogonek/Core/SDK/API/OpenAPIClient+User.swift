//
//  OpenAPIClient+User.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension OpenAPIClient {
    func fetchMe(_: Operations.FetchMe.Input) async throws -> Operations.FetchMe.Output {
        notImplemented()
    }

    func updateUser(_: Operations.UpdateUser.Input) async throws -> Operations.UpdateUser.Output {
        notImplemented()
    }

    func deleteUser(_: Operations.DeleteUser.Input) async throws -> Operations.DeleteUser.Output {
        notImplemented()
    }

    func fetchInviter(_: Operations.FetchInviter.Input) async throws -> Operations.FetchInviter.Output {
        notImplemented()
    }

    func fetchProfile(_: Operations.FetchProfile.Input) async throws -> Operations.FetchProfile.Output {
        notImplemented()
    }

    func upsertProfile(_: Operations.UpsertProfile.Input) async throws -> Operations.UpsertProfile.Output {
        notImplemented()
    }

    func upsertStudent(_: Operations.UpsertStudent.Input) async throws -> Operations.UpsertStudent.Output {
        notImplemented()
    }

    func removeStudent(_: Operations.RemoveStudent.Input) async throws -> Operations.RemoveStudent.Output {
        notImplemented()
    }

    func updateStudent(_: Operations.UpdateStudent.Input) async throws -> Operations.UpdateStudent.Output {
        notImplemented()
    }

    func fetchStudent(_: Operations.FetchStudent.Input) async throws -> Operations.FetchStudent.Output {
        notImplemented()
    }

    func listStudents(_: Operations.ListStudents.Input) async throws -> Operations.ListStudents.Output {
        notImplemented()
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
