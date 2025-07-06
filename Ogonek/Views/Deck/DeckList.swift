//
//  DeckList.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct DeckListView: View {
    @Environment(DeckProvider.self) var provider
    @State var isLoading = false
    @State private var error: DeckError?
    @State private var hasError: Bool = false
    @State var selection: Set<String> = []

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(provider.decks) { deck in
                        DeckCard(deck: deck)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Flashcards")
            .refreshable {
                await fetchDecks()
            }
            .alert(isPresented: $hasError, error: error) {}
            .navigationDestination(for: Deck.self) { deck in DeckDetail(deck: deck, cards: Card.previewSet) }
        }

        .task {
            await fetchDecks()
        }
    }
}

extension DeckListView {
    func fetchDecks() async {
        isLoading = true

        do {
            try await provider.fetchDecks()

        } catch {
            self.error = error as? DeckError ?? .core(.unexpectedError(error))
            hasError = true
        }
        isLoading = false
    }
}

#Preview {
    DeckListView()
        .environment(
            DeckProvider(client: DeckClient(downloader: TestDownloader()))
        )
}
