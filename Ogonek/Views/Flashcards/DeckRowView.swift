import SwiftUI

struct DeckRowView: View {
    let deck: DeckSmall

    var body: some View {
        NavigationLink {
            DeckDetailView(deckId: deck.id)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                Text(deck.name)
                    .font(.headline)
                    .lineLimit(2)
            }
        }
    }
}
