//
//  WordCard.swift
//  Ogonek
//
//  Created by Danila Volkov on 05.07.2025.
//

import SwiftUI

struct WordCard: View {
    var card: Card

    @State private var selectedSide = 0

    var body: some View {
        VStack {
            Picker("Card Side", selection: $selectedSide) {
                Text("Front").tag(0)
                Text("Back").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        Spacer()

        Text(selectedSide == 0 ? card.front : card.back).font(.title).padding()

        Spacer()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WordCard(card: Card.preview)
}
