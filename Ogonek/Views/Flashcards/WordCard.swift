// MARK: - WordCard Component

import SwiftUI

struct WordCard: View {
    let card: Card
    @Binding var flippedCards: Set<String>
    let onTap: (String) -> Void

    private var isFlipped: Bool {
        flippedCards.contains(card.id)
    }

    var body: some View {
        Button {
            onTap(card.id)
        } label: {
            ZStack {
                // Card container
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1),
                    )
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

                VStack(spacing: 16) {
                    // Front/Back content
                    VStack(alignment: .leading, spacing: 8) {
                        Text(isFlipped ? "Answer" : "Question")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(isFlipped ? card.back : card.front)
                            .font(.body)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(4)
                    }

                    if let mediaUrl = card.mediaUrl,
                       let encoded = mediaUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encoded), isFlipped {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray6))
                                .frame(maxHeight: 120)
                                .overlay(ProgressView())
                        }
                    }

                    Spacer()

                    // Flip indicator
                    if !isFlipped {
                        HStack {
                            Spacer()
                            VStack(spacing: 4) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Tap to flip")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .frame(height: 180)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.3), value: isFlipped)
    }
}
