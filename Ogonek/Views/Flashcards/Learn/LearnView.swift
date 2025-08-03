import SwiftUI

/// The button that the user clicks
struct QualityButton: Identifiable {
    let id = UUID()
    let key: Int
    let quality: Int
    let color: Color
    let label: String
}

// MARK: - Main View

struct LearnView: View {
    @StateObject private var viewModel = LearnViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(.systemGray6), Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom,
                )
                .ignoresSafeArea()

                if viewModel.isComplete || viewModel.cards.isEmpty {
                    completionView
                } else if let currentCard = viewModel.currentCard {
                    cardView(card: currentCard)
                } else {
                    loadingView
                }
            }
            .navigationTitle("Learn")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadCards()
            }
        }
    }

    // MARK: - Completion View

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            // Success icon
            ZStack {
                Circle()
                    .fill(Color.brown.opacity(0.1))
                    .frame(width: 80, height: 80)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.brown)
            }

            VStack(spacing: 12) {
                Text("All caught up!")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("You've reviewed all your due cards. Come back later for new cards to review.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(action: { dismiss() }) {
                HStack {
                    Image(systemName: "house.fill")
                    Text("Words Page")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.brown)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Spacer()
        }
        .transition(.opacity.combined(with: .scale))
    }

    // MARK: - Card View

    private func cardView(card: CardProgress) -> some View {
        VStack(spacing: 24) {
            // Header with progress
            headerView

            // Progress bar
            progressBar

            // Card content
            cardContent(card: card)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity),
                ))
        }
        .padding(.horizontal, 20)
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentIndex)
    }

    // MARK: - Header View

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Card \(viewModel.currentIndex + 1) of \(viewModel.cards.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text("\(Int(viewModel.progress * 100))% Complete")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.brown)
        }
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.brown)
                    .frame(width: geometry.size.width * viewModel.progress, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.progress)
            }
        }
        .frame(height: 8)
    }

    // MARK: - Card Content

    private func cardContent(card: CardProgress) -> some View {
        VStack(spacing: 16) {
            // Main card
            VStack(spacing: 0) {
                // Front side
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Front")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        Spacer()
                    }

                    if viewModel.showCloze {
                        clozeInput(front: card.front)
                    } else {
                        Text(card.front)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)

                if viewModel.showAnswer {
                    Divider()
                        .padding(.horizontal, 20)

                    // Back side
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Back")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            Spacer()
                        }

                        Text(card.back)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, minHeight: 80, alignment: .topLeading)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)

            // Action buttons
            actionButtons
        }
    }

    // MARK: - Cloze Input

    private func clozeInput(front: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(front)
                .font(.title3)
                .multilineTextAlignment(.leading)

            TextField("Type your answer...", text: $viewModel.userInput)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    viewModel.showAnswerPressed()
                }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        Group {
            if !viewModel.showAnswer {
                Button(action: viewModel.showAnswerPressed) {
                    HStack {
                        Text("Show Answer")
                        Text(viewModel.showCloze ? "↵" : "Space")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemGray4))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            } else {
                qualityButtonsView
            }
        }
    }

    // MARK: - Quality Buttons

    private var qualityButtonsView: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.qualityButtons) { button in
                Button(action: {
                    Task {
                        await viewModel.submitQuality(button.quality)
                    }
                }) {
                    VStack(spacing: 8) {
                        Text(button.label)
                            .font(.subheadline)
                            .fontWeight(.medium)

                        Text("\(button.key)")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(button.color.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(viewModel.isLoading)
            }
        }
    }

    // MARK: - Loading View

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
            Text("Loading cards...")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview

#Preview {
    LearnView()
}
