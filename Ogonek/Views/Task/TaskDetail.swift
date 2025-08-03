import Combine
import MarkdownUI
import SwiftUI

struct TaskFile: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
    let size: Int64
    let mimeType: String

    enum CodingKeys: String, CodingKey {
        case id, name, url, size
        case mimeType = "mime_type"
    }
}

struct TaskDetailResponse {
    let task: TaskWithFiles
    let files: [TaskFile]
    let rendered: String
}

// MARK: - Task Detail View

struct TaskDetailView: View {
    let task: TaskFull
    let files: [File]

    @State private var showingDeleteAlert = false
    @State private var showingFileUpload: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                taskContentView(task: task)
            }
            .navigationTitle("Task Details")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingFileUpload) {
            FileUploadView(task: task)
        }
    }

    // MARK: - Content Views

    private func taskContentView(task: TaskFull) -> some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                // Header Card
                taskHeaderCard(task: task)

                // Files and Content Section
                HStack(alignment: .top, spacing: 16) {
                    // Files Column (1/4 width)
                    filesSection
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Content Column (3/4 width)
                    contentSection
                        .frame(maxWidth: .infinity * 3, alignment: .leading)
                }
                .padding(.horizontal)
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
                        // TODO:
                        print("toggled completion")
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

    private var filesSection: some View {
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

    private var contentSection: some View {
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

    private var errorView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            Text("Failed to load task")
                .font(.headline)
                .foregroundColor(.primary)
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

// MARK: - Preview

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: MockData.taskWithFiles.task, files: MockData.taskWithFiles.files)
    }
}
