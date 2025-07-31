import SwiftUI

struct DeckCardView: View {
    let deck: DeckSmall

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(deck.name)
                .font(.headline)
                .lineLimit(2)

            Spacer()
        }
        .padding()
        .frame(height: 140)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
