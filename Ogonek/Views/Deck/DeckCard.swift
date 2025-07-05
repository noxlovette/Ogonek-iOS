import SwiftUI

struct DeckCard: View {
    var deck: Deck

    var body: some View {
        NavigationLink(value: deck) {
            VStack(alignment: .leading, spacing: 12) {
                Text(deck.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    ForEach(deck.description.split(separator: ";").map(String.init), id: \.self) { tag in
                        Tag(tag: tag)
                    }
                    Spacer()
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}
