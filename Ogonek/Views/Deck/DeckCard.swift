import SwiftUI

// MARK: - DeckCard Implementation

struct DeckCard: View {
    let deck: Deck
    let action: () -> Void

    init(deck: Deck, action: @escaping () -> Void = {}) {
        self.deck = deck
        self.action = action
    }

    private var visibilityIcon: String {
        switch deck.visibility {
        case "public":
            return "globe"
        case "private":
            return "lock"
        case "assigned":
            return "person"
        default:
            return "questionmark"
        }
    }

    private var visibilityColor: Color {
        switch deck.visibility {
        case "public":
            return .cocoa500
        case "private":
            return .stone500
        case "assigned":
            return .blue
        default:
            return .stone400
        }
    }

    var body: some View {
        NavigationLink(destination: DeckDetailView(deck: Deck.preview, cards: Card.previewSet)) {
            GenericCardView(
                backgroundColor: Color(.systemBackground),
                cornerRadius: 12,
                shadowRadius: 2,
                borderColor: .stone200,
                borderWidth: 1,
                action: action
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    // Header with title and visibility
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(deck.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .lineLimit(2)

                            if let description = deck.description, !description.isEmpty {
                                Text(description)
                                    .font(.caption)
                                    .foregroundColor(.stone600)
                                    .lineLimit(2)
                            } else {
                                Text("No description")
                                    .font(.caption)
                                    .foregroundColor(.stone400)
                                    .italic()
                            }
                        }

                        Spacer()

                        // Visibility indicator
                        Image(systemName: visibilityIcon)
                            .font(.caption)
                            .foregroundColor(visibilityColor)
                            .frame(width: 24, height: 24)
                            .background(
                                Circle()
                                    .fill(visibilityColor.opacity(0.1))
                            )
                    }

                    // Tags section (if description contains semicolon-separated tags)
                    if let description = deck.description, description.contains(";") {
                        TagsView(tags: description.components(separatedBy: ";"))
                    }
                }
            }
        }
    }
}
