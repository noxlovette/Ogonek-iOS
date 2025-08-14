//
//  LoginViewModel.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import Foundation

class LoginViewModel: BaseViewModel {
    @MainActor var username: String = ""
    @MainActor var password: String = ""

    @MainActor var canSignIn: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.isEmpty &&
            !isLoading
    }

    @MainActor
    func signIn() async {
        guard canSignIn else { return }
        isLoading = true
        errorMessage = nil

        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            try await apiService.signIn(username: trimmedUsername, password: password)
            TokenManager.shared.isAuthenticated = true
        } catch {
            handleError(error)
        }
        isLoading = false
    }

    @MainActor
    func clearForm() {
        username = ""
        password = ""
        errorMessage = nil
    }
}
