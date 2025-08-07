import SwiftUI

struct DeckRowView: View {
    let deck: DeckSmall

    var body: some View {
        NavigationLink {
            DeckDetailView(deckId: deck.id)
        } label: {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(deck.name)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)


                         HStack(spacing: 4) {
                             Image(systemName: "rectangle.stack")
                                 .font(.caption2)
                             Text("\(deck.cardCount) cards")
                                 .font(.caption2)
                         }
                         .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DeckRowView(deck: MockData.decks()[0])
}
