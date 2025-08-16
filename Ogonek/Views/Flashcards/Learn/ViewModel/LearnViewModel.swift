//
//  LearnViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@Observable
class LearnViewModel {
    var cards: [CardProgress] = []
    var isComplete: Bool = false
    var isLoading: Bool = false

    let qualityButtons: [QualityButton] = [
        QualityButton(key: 1, quality: 0, color: .red, label: "1066"),
        QualityButton(key: 2, quality: 3, color: .yellow, label: "Good"),
        QualityButton(key: 3, quality: 5, color: .green, label: "Easy"),
    ]

    func loadCards() async {
        isLoading = true
        do {
            if isPreview {
                cards = MockData.cardProgress
            } else {
                cards = try await APIService.shared.fetchDueCards()
            }
            isComplete = cards.isEmpty
        } catch {
            print("Failed to load cards: \(error)")
        }
        isLoading = false
    }

    func submitQuality(_ quality: Int32, for cardID: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }

        do {
            try await APIService.shared.updateProgress(cardID: cardID, quality: quality)
            return true
        } catch {
            print("Failed to submit quality: \(error)")
            return false
        }
    }

    func refreshCards() async {
        await loadCards()
    }
}
