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
        ToolbarItem(placement: .bottomBar) {
            Button(
                (viewModel.deck.deck.isSubscribed ?? false) ? "Unsubscribe" : "Subscribe",
                action: subscribe
            )
        }
    }
}
