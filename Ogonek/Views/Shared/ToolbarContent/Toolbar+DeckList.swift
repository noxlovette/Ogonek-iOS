//
//  Toolbar+DeckList.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension DeckListView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem {
            RefreshButton {
                refreshDecks()
            }
            .accessibilityLabel("Refresh decks")
            .accessibilityHint("Updates deck list with latest data")
        }
    }
}
