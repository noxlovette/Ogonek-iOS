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

    var body: some View {
        NavigationStack {
            List(provider.decks) { deck in
                Text(deck.name)
            }
            .listStyle(.inset)
            .navigationTitle("Flashcards")
            .refreshable {
                await fetchDecks()}
            .alert(isPresented: $hasError, error: error) {}
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
            DeckProvider(client:DeckClient(downloader: TestDownloader()))
        )
}
