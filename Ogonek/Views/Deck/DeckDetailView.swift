import SwiftUI

// MARK: - Tag Badge Component

struct TagBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.brown.opacity(0.1)),
            )
            .foregroundColor(.brown)
    }
}

// MARK: - Main Deck Detail View

struct DeckDetailView: View {
    let deckId: String

    @State private var viewModel = DeckDetailViewModel()
    @State private var flippedCards: Set<String> = []
    @State private var isSubscribed: Bool = false
    @State private var showingShareSheet = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        Group {
            if let deck = viewModel.deck {
                deckContent(deckWithCards: deck)
            } else if viewModel.isLoading {
                ProgressView()
            } else if viewModel.errorMessage != nil {
                Text("Error")
            } else {
                Text("Nothing here")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDeck(id: deckId)
        }
        .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchDeck(id: deckId)
                }
            }
            Button("Cancel", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }

    }

    private func deckContent(deckWithCards: DeckWithCards) -> some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                    // Header section
                headerSection(deck: deckWithCards.deck)

                    // Main content
                HStack(alignment: .top, spacing: 24) {
                        // Cards grid
                    cardsSection(cards: deckWithCards.cards)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(deckWithCards.deck.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if UIDevice.current.userInterfaceIdiom != .pad {
                    Button {
                            // Navigate to edit
                    } label: {
                        Image(systemName: "pencil")
                    }
                }

                Button {
                    showingShareSheet.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(items: ["Check out this deck: \(deckWithCards.deck.name)"])
        }
    }

    private func headerSection(deck: Deck) -> some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(deck.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }

                Spacer()
            }
            .padding(.horizontal)

            // Action buttons
            HStack(spacing: 12) {
                // Share button
                Button {
                    showingShareSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share Deck")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                // Edit button (if owner)
                Button {
                    // Navigate to edit
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                // Subscribe button
                Button {
                    isSubscribed.toggle()
                    // Handle subscription API call
                } label: {
                    HStack {
                        Image(systemName: isSubscribed ? "person.badge.minus" : "person.badge.plus")
                        Text(isSubscribed ? "Unsubscribe" : "Subscribe")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal)
        }
    }


    private func cardsSection(cards: [Card]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if cards.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "rectangle.stack.badge.plus")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)

                    Text("No flashcards available")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text("Add some cards by editing this deck")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
            } else {
                // Cards grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cards) { card in
                        WordCard(
                            card: card,
                            flippedCards: $flippedCards,
                            onTap: toggleCard,
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Helper Methods

    private func toggleCard(_ cardId: String) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if flippedCards.contains(cardId) {
                flippedCards.remove(cardId)
            } else {
                flippedCards.insert(cardId)
            }
        }
    }
}

// MARK: - Share Sheet Helper

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context _: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_: UIActivityViewController, context _: Context) {}
}

// MARK: - Preview

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeckDetailView(deckId: "mock")
        }
    }
}
