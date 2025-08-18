//
//  SettingsViewModel.swift
//  Ogonek
//
//  Created by Danila Volkov on 16.08.2025.
//

import Foundation

@Observable
class SettingsViewModel: BaseViewModel {
    var showNotificationExplanation = false

    @MainActor
    func logout() {
        TokenManager.shared.logout()
    }

    func requestNotificationPermission() {
        showNotificationExplanation = true
    }
}
