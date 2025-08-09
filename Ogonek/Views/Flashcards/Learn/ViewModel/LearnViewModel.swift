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
    var currentIndex: Int = 0
    var isComplete: Bool = false
    var showAnswer: Bool = false
    var userInput: String = ""
    var isLoading: Bool = false

    var currentCard: CardProgress? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }

    var showCloze: Bool {
        guard let card = currentCard else { return false }
        return card.front.split(separator: " ").count < 4
    }

    var progress: Double {
        guard !cards.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(cards.count)
    }

    let qualityButtons: [QualityButton] = [
        QualityButton(key: 1, quality: 0, color: .red, label: "1066"),
        QualityButton(key: 2, quality: 3, color: .yellow, label: "Good"),
        QualityButton(key: 3, quality: 5, color: .green, label: "Easy"),
    ]

    func loadCards() async {
        isLoading = true
        do {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
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

    func submitQuality(_ quality: Int32) async {
        guard let card = currentCard else { return }

        isLoading = true

        do {
            try await APIService.shared
                .updateProgress(cardID: card.id, quality: quality)
            await nextCard()
        } catch {
            print("Failed to submit quality: \(error)")
        }

        isLoading = false
    }

    func nextCard() async {
        userInput = ""

        if currentIndex < cards.count - 1 {
            currentIndex += 1
            showAnswer = false
        } else if currentIndex == cards.count - 1, cards.count > 1 {
            await loadCards()
            currentIndex = 0
            showAnswer = false
        } else {
            isComplete = true
        }
    }

    func showAnswerPressed() {
        showAnswer = true
    }
}
