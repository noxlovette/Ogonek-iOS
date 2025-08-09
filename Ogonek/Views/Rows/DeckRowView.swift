import SwiftUI

struct DeckRowView: View {
    let deck: DeckSmall

    var body: some View {
        NavigationLink {
            DeckDetailView(deckId: deck.id)
        } label: {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Text(deck.name)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)

                        if !(deck.seen ?? false) {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                        }

                        Spacer()
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "rectangle.stack")
                            .font(.caption2)
                        Text("\(deck.cardCount) cards")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                }

                Spacer()

                if let subscribed = deck.isSubscribed {
                    if subscribed {
                        StatusBadge(icon: "checkmark.seal", text: "Subscribed", color: .green)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DeckRowView(deck: MockData.decks()[0])
    DeckRowView(deck: MockData.decks()[1])
    DeckRowView(deck: MockData.decks()[2])
}
