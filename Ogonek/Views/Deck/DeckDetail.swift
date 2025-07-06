import SwiftUI

struct DeckDetail: View {
    var deck: Deck
    var cards: [Card]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(deck.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)

                if !deck.description.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(deck.description.split(separator: ";").map(String.init), id: \.self) { tag in
                                Tag(tag: tag)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                Divider()

                // Cards Section
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(cards) { card in
                        WordCard(card: card)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(deck.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DeckDetail(deck: Deck.preview, cards: Card.previewSet)
}
