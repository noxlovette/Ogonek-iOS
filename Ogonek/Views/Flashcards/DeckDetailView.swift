import SwiftUI

// MARK: - Simplified Deck Detail View

struct DeckDetailView: View {
    let deckId: String

    @State private var viewModel = DeckDetailViewModel()
    @State private var flippedCards: Set<String> = []
    @State private var isSubscribed: Bool = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.deck.cards) { card in
                    WordCard(
                        card: card,
                        flippedCards: $flippedCards,
                        onTap: toggleCard
                    )
                }
            }
            .padding()
        }

        .navigationTitle(viewModel.deck.deck.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 6) {
                    TagsView(
                        tags: viewModel.deck.deck.description?
                            .components(separatedBy: ";") ?? []
                    )
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomToolbar {
                Button(action: subscribe) {
                    HStack(spacing: 8) {
                        if viewModel.deck.deck.isSubscribed ?? false {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "checkmark.circle.empty").foregroundStyle(.secondary)
                        }
                        Text("Subscribe")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .task {
            await viewModel.fetchDeck(id: deckId)
        }
    }

    private func toggleCard(_ cardId: String) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if flippedCards.contains(cardId) {
                flippedCards.remove(cardId)
            } else {
                flippedCards.insert(cardId)
            }
        }
    }

    private func subscribe() {
        Task {
            await viewModel.toggleSubscription()
        }
    }
}

// MARK: - Preview

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeckDetailView(deckId: "mock")
        }
    }
}
