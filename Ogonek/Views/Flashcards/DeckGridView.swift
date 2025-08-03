//
//  DeckGridView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct DeckGridView: View {
    @State private var viewModel = DeckGridViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 160)),
    ]

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.decks.isEmpty, !viewModel.isLoading {
                    Text("No decks found")
                } else {
                    decksGrid
                }
            }
            .navigationTitle("Decks")
            .refreshable {
                await viewModel.loadDecks()
            }
            .task {
                await viewModel.loadDecks()
            }

        }.alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }

    private var decksGrid: some View {
        List {
            ForEach(viewModel.decks) { deck in
                NavigationLink(value: deck.id) {
                    DeckCardView(deck: deck)
                }
            }

            if viewModel.isLoading, !viewModel.decks.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
        .listStyle(.inset)
        .navigationDestination(for: String.self) { deckId in
            DeckDetailView(deckId: deckId)
        }
        .overlay {
            if viewModel.isLoading, viewModel.decks.isEmpty {
                ProgressView("Loading deckks...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
            }
        }
    }
}
