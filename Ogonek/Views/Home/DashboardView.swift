import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section("Tasks") {
                    if viewModel.dueTasks.isEmpty {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
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
                                .foregroundStyle(.blue)
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
            .safeAreaInset(edge: .bottom) {
                bottomToolbar
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refreshDashboard()
            }
            .task {
                await viewModel.loadDashboardData()
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

    // MARK: - Bottom Toolbar

    private var bottomToolbar: some View {
        HStack {
            NavigationLink {
                LearnView()
            } label: {
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("Learn")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.regularMaterial, ignoresSafeAreaEdges: .bottom)
    }
}

#Preview {
    DashboardView()
}
