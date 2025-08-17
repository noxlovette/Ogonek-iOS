//
//  BaseViewModel.swift
//  Ogonek
//
//  Created by Danila Volkov on 14.08.2025.
//

import Foundation

@Observable
class BaseViewModel {
    var errorMessage: String?
    var isLoading: Bool = false

    let apiService: APIService

    init() {
        apiService = APIService.shared
    }

    init(apiService: APIService) {
        self.apiService = apiService
    }

    @MainActor var hasError: Bool {
        get { errorMessage != nil }
        set { if !newValue { errorMessage = nil } }
    }

    func handleError(_ error: Error) {
        switch error {
        case APIError.unauthorized:
            errorMessage = "Authentication failed"
        case let APIError.serverError(statusCode):
            errorMessage = "Server error (\(statusCode)). Please try again."
        default:
            errorMessage = "An error occurred. Please try again."
        }
    }

    func clearError() {
        errorMessage = ""
    }

    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
}
