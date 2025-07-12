//
//  DeckList.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

    // MARK: - Usage Example
struct DeckGridView: View {
    let decks: [Deck]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                        // Header similar to your HeaderEmbellish
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Flashcards")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("\(decks.count) decks available")
                                .font(.subheadline)
                                .foregroundColor(.stone600)
                        }

                        Spacer()

                        Button("New Deck") {
                                // Handle new deck creation
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.cocoa500)
                    }
                    .padding(.horizontal)

                        // Deck grid
                    if decks.isEmpty {
                            // Empty state
                        VStack(spacing: 12) {
                            Image(systemName: "folder")
                                .font(.system(size: 32))
                                .foregroundColor(.stone400)

                            Text("No decks")
                                .font(.headline)
                                .foregroundColor(.stone700)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 60)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(decks) { deck in
                                DeckCard(deck: deck) {
                                        // Handle deck tap - navigate to deck detail
                                    print("Tapped deck: \(deck.name)")
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

    // MARK: - Preview
struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
                // Single card preview
            DeckCard(deck: Deck.previewSet[0]) {
                print("Deck tapped!")
            }
            .padding()
            .previewDisplayName("Single Card")

                // Grid view preview
            DeckGridView(decks: Deck.previewSet)
                .previewDisplayName("Grid View")

                // Empty state preview
            DeckGridView(decks: [])
                .previewDisplayName("Empty State")
        }
    }
}
