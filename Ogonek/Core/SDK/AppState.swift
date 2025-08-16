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

    private var lastBadgeFetch: Date?
    private var badgeRefreshInterval: TimeInterval = 30
    private var backgroundRefreshTimer: Timer?

    override init() {
        super.init()
        startBackgroundRefresh()
    }

    @MainActor
    func fetchBadges(force: Bool = false) async {

        if !force, let lastFetch = lastBadgeFetch,
            Date().timeIntervalSince(lastFetch) < badgeRefreshInterval {
            return
        }

        do {
            if isPreview {
                badges = MockData.badges
                return
            }
            badges = try await apiService.fetchBadges()
            lastBadgeFetch = Date()
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

    private func startBackgroundRefresh() {
        backgroundRefreshTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            Task { @MainActor in
                await self?.fetchBadges(force: true)
            }
        }
    }

    func refreshAllData() async {
        await fetchBadges(force: true)
        await fetchContext()
    }

}
