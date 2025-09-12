import SwiftUI

struct DeckDetailView: View {
    let deckId: String

    @State var viewModel = DeckDetailViewModel()
    @State private var flippedCards: Set<String> = []


    var body: some View {
        VStack {
            if let deck = viewModel.deck {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(deck.cards, id: \.id) { card in
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
                LoadingOverlay()
            }
        }
        .navigationTitle(viewModel.deck?.deck.title ?? "Loading...")
        .toolbar {
            toolbarContent()
        }
        .overlay {
            if viewModel.isLoading {
                LoadingOverlay()
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

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeckDetailView(deckId: "mock")
        }
    }
}
