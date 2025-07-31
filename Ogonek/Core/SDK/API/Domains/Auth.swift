//
//  Auth.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension OpenAPIClient {
    func signIn(username: String, pass: String) async throws {
        let input = Operations.Signin.Input(
            body: .json(.init(pass: pass, username: username)),
        )

        let response = try await client.signin(input)

        switch response {
        case let .ok(okResponse):
            switch okResponse.body {
            case let .json(tokenPair):
                TokenStorage
                    .store(
                        token: tokenPair.accessToken.token,
                        refreshToken: tokenPair
                            .refreshToken.token,
                    )
                setAuthToken(tokenPair.accessToken.token)
            }
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    func logout() {
        TokenStorage.clearTokens()
        clearAuth()
    }

    func signup(_: Operations.Signup.Input) async throws -> Operations.Signup.Output {
        notImplemented()
    }

    func refresh(_: Operations.Refresh.Input) async throws -> Operations.Refresh.Output {
        notImplemented()
    }

    func bindStudentToTeacher(_: Operations.BindStudentToTeacher.Input) async throws -> Operations.BindStudentToTeacher.Output {
        notImplemented()
    }

    func generateInviteLink(_: Operations.GenerateInviteLink.Input) async throws -> Operations.GenerateInviteLink.Output {
        notImplemented()
    }
}
