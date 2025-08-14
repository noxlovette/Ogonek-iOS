
//
//  MockAPIService.swift
//  OgonekTests
//

import Foundation
@testable import Ogonek

class MockAPIService {
    var shouldSucceed = true
    var errorToThrow: Error = APIError.unauthorized
    var signInWasCalled = false
    var lastUsername: String?
    var lastPassword: String?

    func signIn(username: String, password: String) async throws {
        signInWasCalled = true
        lastUsername = username
        lastPassword = password

        try await Task.sleep(nanoseconds: 10_000_000) // 0.01 seconds

        if shouldSucceed {
            await MainActor.run {
                TokenManager.shared.isAuthenticated = true
            }
        } else {
            throw errorToThrow
        }
    }

    func reset() {
        shouldSucceed = true
        errorToThrow = APIError.unauthorized
        signInWasCalled = false
        lastUsername = nil
        lastPassword = nil
    }
}
