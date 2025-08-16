//
//  AppState.swift
//  Ogonek
//
//  Created by Danila Volkov on 16.08.2025.
//

import Foundation

class AppState: BaseViewModel {
    var badges: NotificationBadges?
    var context: AppContext?

    @MainActor
    func fetchBadges(force _: Bool = false) async {
        do {
            if isPreview {
                badges = MockData.badges
                return
            }
            badges = try await apiService.fetchBadges()
        } catch {
            handleError(error)
        }
    }

    @MainActor
    func fetchContext() async {
        do {
            context = try await apiService.fetchContext()
        } catch {
            handleError(error)
        }
    }
}
