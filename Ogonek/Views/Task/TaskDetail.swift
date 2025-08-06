import MarkdownUI
import SwiftUI

struct TaskDetailView: View {
    @State private var showingDeleteAlert = false
    @State private var showingFileUpload: Bool = false
    @State private var viewModel: TaskDetailViewModel

    init(taskID: String = "mock") {
        viewModel = .init(taskID: taskID)
    }

    var body: some View {
        ScrollView {
            VStack {
                Markdown(viewModel.taskWithFiles?.task.markdown ?? "Loading...")
            }
            .padding()
            .navigationTitle(viewModel.taskWithFiles?.task.title ?? "Task Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup() {
                    Button(
                        "Files",
                        systemImage: "folder"

                    ) {
                        showingFileUpload = true
                    }

                    Button(
                        "Complete", systemImage: "checkmark", action: {
                            Task {
                                await viewModel.toggleTaskCompletion()
                            }
                        }
                    ).labelStyle(.iconOnly).buttonStyle(.borderedProminent)
                }
            }
            .task {
                await viewModel.fetchTask()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.taskWithFiles == nil {
                    errorView(message: "Task not found")
                }
            }
            .sheet(isPresented: $showingFileUpload) {
                FilesView(files: viewModel.taskWithFiles?.files ?? [])
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchTask()
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
                    await viewModel.fetchTask()
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
        TaskDetailView()
    }
}
