//
//  LearnViewState.swift
//  Ogonek
//
//  Created by Danila Volkov on 10.08.2025.
//

import SwiftUI

struct LearnViewState {
    var showAnswer: Bool = false
    var userInput: String = ""
    var currentIndex: Int = 0

    var progress: Double {
        guard !cards.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(cards.count)
    }

    var showCloze: Bool {
        guard let card = currentCard else { return false }
        return card.front.split(separator: " ").count < 4
    }

    var currentCard: CardProgress? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }

    var cards: [CardProgress] = []
    var isComplete: Bool = false
}
