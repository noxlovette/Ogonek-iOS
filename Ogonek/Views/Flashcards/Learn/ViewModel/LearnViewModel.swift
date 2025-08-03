//
//  LearnViewModel.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import Foundation
import Observation

@MainActor
class LearnViewModel: ObservableObject {
    @Published var cards: [CardProgress] = []
    @Published var currentIndex: Int = 0
    @Published var isComplete: Bool = false
    @Published var showAnswer: Bool = false
    @Published var userInput: String = ""
    @Published var isLoading: Bool = false

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
        QualityButton(key: 1, quality: 0, color: .red, label: "Again"),
        QualityButton(key: 2, quality: 1, color: .orange, label: "Hard"),
        QualityButton(key: 3, quality: 2, color: .blue, label: "Good"),
        QualityButton(key: 4, quality: 3, color: .green, label: "Easy"),
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

    func submitQuality(_: Int) async {
        guard let card = currentCard else { return }

        isLoading = true

        do {
            // await APIService.shared.updateCardProgress(cardId: card.id, quality: quality)
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
            // Reload cards and reset
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
