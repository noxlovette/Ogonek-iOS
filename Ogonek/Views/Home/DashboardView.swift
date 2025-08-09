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
            .navigationTitle("Dashboard")
            .toolbar {
                toolbarContent()
            }
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

    func refreshDashboard() {
        Task {
            await viewModel.refreshDashboard()
        }
    }
}

#Preview {
    DashboardView()
}
