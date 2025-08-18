import SwiftUI

struct QualityButton: Identifiable {
    let id = UUID()
    let key: Int
    let quality: Int32
    let color: Color
    let label: String
}

struct LearnView: View {
    @State private var viewModel = LearnViewModel()
    @State private var viewState: LearnViewState
    init(viewState: LearnViewState = LearnViewState()) {
        _viewState = State(initialValue: viewState)
    }

    @Environment(\.dismiss) private var dismiss

    let qualityButtons: [QualityButton] = [
        QualityButton(
            key: 1,
            quality: 0,
            color: .secondaryColour,
            label: "1066"
        ),
        QualityButton(key: 2, quality: 3, color: .secondary, label: "Good"),
        QualityButton(key: 3, quality: 5, color: .accent, label: "Easy"),
    ]


    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isComplete || viewModel.cards.isEmpty {
                    completionView
                } else if let currentCard = viewState.currentCard {
                    cardView(card: currentCard)
                }
            }
            .navigationTitle("Learn")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await loadData()
            }
            .onChange(of: viewModel.cards) { _, newCards in
                updateViewState(with: newCards)
            }
        }
    }

    // MARK: - Actions

    private func loadData() async {
        await viewModel.loadCards()
        updateViewState(with: viewModel.cards)
    }

    private func updateViewState(with cards: [CardProgress]) {
        viewState.cards = cards
        viewState.isComplete = viewModel.isComplete
    }

    private func showAnswer() {
        viewState.showAnswer = true
    }

    private func submitQuality(_ quality: Int32) async {
        guard let card = viewState.currentCard else { return }

        let success = await viewModel.submitQuality(quality, for: card.id)
        if success {
            nextCard()
        }
    }

    private func nextCard() {
        viewState.userInput = ""

        if viewState.currentIndex < viewState.cards.count - 1 {
            viewState.currentIndex += 1
            viewState.showAnswer = false
        } else if viewState.currentIndex == viewState.cards.count - 1, viewState.cards.count > 1 {
            Task {
                await viewModel.refreshCards()
                viewState.currentIndex = 0
                viewState.showAnswer = false
            }
        } else {
            viewState.isComplete = true
        }
    }

    // MARK: - Completion View

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 80, height: 80)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }

            VStack(spacing: 12) {
                Text("You've reviewed all your due cards. Come back later for new cards to review.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Button(
                action: { dismiss() },
                label: {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("To Dashboard")
                    }
                    .padding()
                }
            )

            Spacer()
        }
    }

    // MARK: - Card View

    private func cardView(card: CardProgress) -> some View {
        VStack {
            progressBar
            Spacer()
            cardContent(card: card)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
            Spacer()
            actionButtons
        }
        .padding()
    }

    private var progressBar: some View {
        VStack(spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Card \(viewState.currentIndex + 1) of \(viewState.cards.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text("\(Int(viewState.progress * 100))% Complete")
                    .font(.caption)
                    .fontWeight(.medium)
            }

            ProgressView(value: viewState.progress)
        }
    }

    // MARK: - Card Content

    private func cardContent(card: CardProgress) -> some View {
        VStack(spacing: 16) {
            // Front
            VStack(alignment: .leading, spacing: 16) {
                if viewState.showCloze {
                    clozeInput(front: card.front)
                } else {
                    Text(card.front)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let mediaUrl = card.mediaUrl,
                   let encoded = mediaUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: encoded)
                {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray6))
                            .frame(maxHeight: 180)
                            .overlay(ProgressView())
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
            .accessibilityLabel("Question: \(card.front)")
            .accessibilityAddTraits(.isStaticText)

            if viewState.showAnswer {
                Divider()
                    .padding(.horizontal, 20)

                VStack(alignment: .leading) {
                    Text(card.back)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .frame(maxWidth: .infinity, minHeight: 80, alignment: .topLeading)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .accessibilityLabel("Answer: \(card.back)")
                .accessibilityAddTraits(.isStaticText)
            }
        }
    }

    // MARK: - Cloze Input

    private func clozeInput(front: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(front)
                .font(.title3)
                .multilineTextAlignment(.leading)

            TextField("Type your answer...", text: $viewState.userInput)
                .onSubmit {
                    showAnswer()
                }
        }
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        Group {
            if !viewState.showAnswer {
                Button(action: showAnswer) {
                    HStack {
                        Text("Show Answer")
                    }
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
                Button(
                    action: {
                        Task {
                            await submitQuality(button.quality)
                        }
                    },
                    label: {
                        VStack(spacing: 8) {
                            Text(button.label)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(button.color)
                        .clipShape(Capsule())
                    }
                )
                .accessibilityLabel("Rate difficulty as \(button.label)")
                .accessibilityHint("This affects when you'll see this card again")
                .accessibilityAddTraits(.isButton)
            }
        }
    }
}

#Preview("Answer Revealed") {
    LearnView(viewState: LearnViewState(
        showAnswer: true,
        cards: MockData.cardProgress,
    ))
}

#Preview("Card Showing") {
    LearnView(viewState: LearnViewState(
        cards: MockData.cardProgress
    ))
}

#Preview("Empty State") {
    LearnView(viewState: LearnViewState(
    ))
}
