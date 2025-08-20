//
//  Toolbar+DeckDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension DeckDetailView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            let isSubscribed =
                viewModel.deck?.deck.isSubscribed ?? false

            CompleteButton(
                action: subscribe,
                condition: isSubscribed,
                recto: "Unsubscribe",
                verso: "Subscribe"
            )
            .tint(isSubscribed
                == true ? .green : .accent)
        }
    }
}
