//
//  DeckDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 05.07.2025.
//

import SwiftUI

struct DeckDetail: View {
    var deck: Deck

    var body: some View {
        Text(deck.name)
    }
}

#Preview {
    DeckDetail(deck: Deck.preview)
}
