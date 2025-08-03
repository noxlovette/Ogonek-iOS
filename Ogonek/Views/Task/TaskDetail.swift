import MarkdownUI
import SwiftUI

struct TaskDetailView: View {
    @State private var showingDeleteAlert = false
    @State private var showingFileUpload: Bool = false
    @State private var viewModel = TaskDetailViewModel()

    let taskId: String

    var body: some View {
        Group {
            if let taskWithFiles = viewModel.task {
                taskContentView(task: taskWithFiles.task, files: taskWithFiles.files)
            } else if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else {
                Text("Empty View")
            }
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.fetchTask(id: taskId)
        }
        .sheet(isPresented: $showingFileUpload) {
            if let task = viewModel.task?.task {
                FileUploadView(task: task)
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchTask(id: taskId)
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
    }

    // MARK: - Content Views

    private func taskContentView(task: TaskFull, files: [File]) -> some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 20) {
                    // Header Card
                    taskHeaderCard(task: task)

                    // Files and Content Section
                    HStack(alignment: .top, spacing: 16) {
                        // Files Column (1/4 width)
                        filesSection(files: files)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Content Column (3/4 width)
                        contentSection(task: task)
                            .frame(maxWidth: .infinity * 3, alignment: .leading)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    private func taskHeaderCard(task: TaskFull) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)

                Text("Created \(task.createdAt.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 12) {
                // Completion Toggle
                Button(action: {
                    Task {
                        // TODO: Implement completion toggle in ViewModel
                        await viewModel.toggleTaskCompletion()
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: task.completed ? "checkmark.square.fill" : "square")
                            .font(.title2)
                        Text(task.completed ? "Completed" : "Mark Done")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(task.completed ? Color.green : Color.blue),
                    )
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2),
        )
        .padding(.horizontal)
    }

    private func filesSection(files: [File]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Attached Files")
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.primary)

                ForEach(files) { file in
                    FileTaskCard(file: file)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Upload your HW here")
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.primary)

                Button(action: {
                    showingFileUpload = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Files")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue),
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.top)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground)),
        )
    }

    private func contentSection(task: TaskFull) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline.weight(.semibold))
                .foregroundColor(.primary)

            ScrollView {
                Markdown(task.markdown)
            }
            .frame(minHeight: 200)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground)),
        )
    }

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading task...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            Text("Failed to load task")
                .font(.headline)
                .foregroundColor(.primary)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Retry") {
                Task {
                    await viewModel.fetchTask(id: taskId)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Supporting Views

struct FileTaskCard: View {
    let file: File

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(file.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(formatFileSize(file.size))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.tertiarySystemGroupedBackground)),
        )
    }

    private func formatFileSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}

struct FileUploadView: View {
    let task: TaskFull

    var body: some View {
        NavigationView {
            Text("File Upload View - TODO")
                .navigationTitle("Upload Files")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(taskId: "mock")
    }
}
