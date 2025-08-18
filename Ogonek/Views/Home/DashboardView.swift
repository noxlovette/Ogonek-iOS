import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    @State private var appState = AppState.shared

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section("Tasks") {
                        if viewModel.dueTasks.isEmpty {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.secondaryColour)
                                VStack(alignment: .leading) {
                                    Text("All caught up!")
                                        .font(.headline)
                                    Text("No tasks due right now")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .listRowSeparator(.hidden)
                        } else {
                            ForEach(viewModel.dueTasks) { task in
                                TaskRowView(task: task)
                            }
                        }
                    }

                    Section("Lessons") {
                        if viewModel.recentLessons.isEmpty {
                            HStack {
                                Image(systemName: "book.fill")
                                    .foregroundStyle(.secondaryColour)
                                VStack(alignment: .leading) {
                                    Text("No recent lessons")
                                        .font(.headline)
                                    Text("Your recent lessons will appear here")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .listRowSeparator(.hidden)
                        } else {
                            ForEach(viewModel.recentLessons) { lesson in
                                LessonRowView(lesson: lesson)
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            LearnView()
                        } label: {
                            ZStack {
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Circle().fill(Color.secondaryColour))

                                if let dueCards = appState.badges.dueCards, dueCards > 0 {
                                    Text("\(dueCards)")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(minWidth: 20, minHeight: 20)
                                        .background(Circle().fill(.red))
                                        .offset(x: 20, y: -20)
                                }
                            }
                        }
                        .padding()
                        .accessibilityLabel("Learn flashcards")
                        .accessibilityHint("Review \(appState.badges.dueCards ?? 0) due cards")
                    }
                }
            }.navigationTitle("Dashboard")
                .toolbar {
                    toolbarContent()
                }
                .refreshable {
                    await viewModel.refreshDashboard()
                    await appState.fetchBadges()
                }
                .task {
                    await viewModel.loadDashboardData()
                    await appState.fetchBadges()
                }
                .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
                    Button("Retry") {
                        Task {
                            await viewModel.loadDashboardData()
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        viewModel.errorMessage = nil
                    }
                } message: {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    }
                }

                .overlay {
                    if viewModel.isLoading, viewModel.dueTasks.isEmpty {
                        ProgressView("Loading dashboard...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.clear)
                    }
                }
        }
    }

    func refreshDashboard() {
        Task {
            await viewModel.refreshDashboard()
        }
    }

    func logout() {
        TokenManager.shared.logout()
    }
}

#Preview {
    DashboardView()
}
