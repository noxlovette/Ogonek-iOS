import SwiftUI

// MARK: - Simplified Deck Detail View

struct DeckDetailView: View {
    let deckId: String

    @StateObject var viewModel = DeckDetailViewModel()
    @State private var flippedCards: Set<String> = []

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            if let deck = viewModel.deck {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(deck.cards) { card in
                            WordCard(
                                card: card,
                                flippedCards: $flippedCards,
                                onTap: toggleCard
                            )
                        }
                    }
                    .padding()
                }
            } else {
                loadingOverlay
            }
        }
        .navigationTitle(viewModel.deck?.deck.title ?? "Loading...")
        .toolbar {
            toolbarContent()
        }
        .overlay {
            if viewModel.isLoading {
                loadingOverlay
            }
        }
        .alert("Error", isPresented: $viewModel.hasError) {
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
}

extension DeckDetailView {
    private var loadingOverlay: some View {
        ProgressView("Loading deck...")
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
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
