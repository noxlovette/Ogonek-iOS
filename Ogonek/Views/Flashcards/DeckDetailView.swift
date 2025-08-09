import SwiftUI

// MARK: - Simplified Deck Detail View

struct DeckDetailView: View {
    let deckId: String

    @State var viewModel = DeckDetailViewModel()
    @State private var flippedCards: Set<String> = []

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
        .toolbar {
            toolbarContent()
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchDeck(id: deckId)
                }
            }
            Button("Cancel", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let message = viewModel.errorMessage {
                Text(message)
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

    func subscribe() {
        Task {
            await viewModel.toggleSubscription()
            await viewModel.fetchDeck(id: deckId)
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
