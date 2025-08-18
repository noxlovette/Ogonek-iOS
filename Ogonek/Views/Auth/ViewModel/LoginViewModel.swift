//
//  LoginViewModel.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import Foundation

@Observable
class LoginViewModel: BaseViewModel {
    var username: String = ""
    var password: String = ""

    @MainActor
    func signIn() async {
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
