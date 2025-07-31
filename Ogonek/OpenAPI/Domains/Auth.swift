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
            body: .json(.init(pass: pass, username: username))
        )

        let response = try await self.client.signin(input)

        switch response {
            case .ok(let okResponse):
                switch okResponse.body {
                    case .json(let tokenPair):
                        TokenStorage
                            .store(
                                token: tokenPair.accessToken,
                                refreshToken: tokenPair
                                    .refreshToken)
                        self.setAuthToken(tokenPair.accessToken.token)
                }
            case .unauthorized:
                throw APIError.unauthorized
            case .undocumented(statusCode: let statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

    func logout() {
        TokenStorage.clearTokens()
        self.clearAuth()
    }

    func signup(_ input: Operations.Signup.Input) async throws -> Operations.Signup.Output {
        notImplemented()
    }

    func refresh(_ input: Operations.Refresh.Input) async throws -> Operations.Refresh.Output {
        notImplemented()
    }

    func bindStudentToTeacher(_ input: Operations.BindStudentToTeacher.Input) async throws -> Operations.BindStudentToTeacher.Output {
        notImplemented()
    }

    func generateInviteLink(_ input: Operations.GenerateInviteLink.Input) async throws -> Operations.GenerateInviteLink.Output {
        notImplemented()
    }

}
