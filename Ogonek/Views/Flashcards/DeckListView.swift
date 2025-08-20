//
//  DeckListView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct DeckListView: View {
    @State private var viewModel = DeckListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.decks) { deck in
                    DeckRowView(deck: deck)
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
            .overlay {
                if viewModel.isLoading, viewModel.decks.isEmpty {
                    ProgressView("Loading decks...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                } else if viewModel.decks.isEmpty {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "No decks",
                        description: "Create some in the web version"
                    )
                } else if viewModel.decks.isEmpty, searchText != "" {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "No decks found",
                        description: "Try a different search"
                    )
                }
            }
            .navigationTitle("Decks")
            .searchable(text: $searchText, prompt: "Search decks...")
            .accessibilityLabel("Search flashcards")
            .accessibilityHint("Type to filter flashard list")
            .refreshable {
                await viewModel.loadDecks()
            }
            .toolbar {
                toolbarContent()
            }
            .task {
                await viewModel.loadDecks()
            }
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.searchDecks(query: newValue)
                }
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

    func refreshDecks() {
        Task {
            await viewModel.refreshDecks()
        }
    }
}

#Preview {
    DeckListView()
}
