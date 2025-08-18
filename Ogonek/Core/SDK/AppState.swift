//
//  AppState.swift
//  Ogonek
//
//  Created by Danila Volkov on 16.08.2025.
//

import Foundation

@Observable
class AppState: BaseViewModel {
    static let shared = AppState()

    var badges = NotificationBadges()
    var context: AppContext?

    @MainActor
    func fetchBadges() async {
        do {
            if isPreview {
                badges = MockData.badges
                print(badges)
                return
            }
            badges = try await apiService.fetchBadges()
            print(badges)
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
