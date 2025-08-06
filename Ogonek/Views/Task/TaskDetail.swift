import MarkdownUI
import SwiftUI
import UniformTypeIdentifiers
import ZipArchive

struct TaskDetailView: View {
    @State private var showingDeleteAlert = false
    @State private var showingFileUpload: Bool = false
    @State private var showingShareSheet = false
    @State private var shareURL: URL?
    @State private var isDownloading = false
    @State private var downloadProgress: Double = 0.0
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
        }
        .navigationTitle(viewModel.taskWithFiles?.task.title ?? "Task Details")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItemGroup {
                Button("Files", systemImage: "folder") {
                    showingFileUpload = true
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            bottomToolbar
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
        .overlay {
            if isDownloading {
                downloadOverlay
            }
        }
        .sheet(isPresented: $showingFileUpload) {
            FilesView(files: viewModel.taskWithFiles?.files ?? [])
        }
        .sheet(isPresented: $showingShareSheet) {
            if let shareURL {
                ShareSheet(items: [shareURL])
            }
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

    // MARK: - Bottom Toolbar

    private var bottomToolbar: some View {
        HStack(spacing: 16) {
            Button(action: downloadTask) {
                HStack(spacing: 8) {
                    if isDownloading {
                        ProgressView()
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "arrow.down.circle.fill")
                    }
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(isDownloading || viewModel.taskWithFiles == nil)

            Button(action: markAsComplete) {
                HStack(spacing: 8) {
                    Image(systemName: viewModel.taskWithFiles?.task.completed == true ?
                        "checkmark.circle.fill" : "circle")
                    Text(viewModel.taskWithFiles?.task.completed == true ?
                        "Completed" : "Complete")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(viewModel.taskWithFiles?.task.completed == true ? .green : .blue)
            .disabled(viewModel.taskWithFiles == nil)
        }
        .padding()
        .background(.regularMaterial, ignoresSafeAreaEdges: .bottom)
    }

    // MARK: - Download Overlay

    private var downloadOverlay: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView(value: downloadProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 200)

                Text("Preparing download...")
                    .font(.headline)

                Text("\(Int(downloadProgress * 100))%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(24)
            .background(.regularMaterial)
            .cornerRadius(12)
        }
    }

    // MARK: - Actions

    private func downloadTask() {
        Task {
            await performDownload()
        }
    }

    private func markAsComplete() {
        Task {
            await viewModel.toggleTaskCompletion()
        }
    }

    @MainActor
    private func performDownload() async {
        guard let taskWithFiles = viewModel.taskWithFiles else { return }

        isDownloading = true
        downloadProgress = 0.0

        do {
            // Step 1: Get presigned URLs (10% of progress)
            downloadProgress = 0.1
            let presignedURLs = try await viewModel.getPresignedURLs()

            // Step 2: Download files (60% of progress)
            downloadProgress = 0.2
            let downloadedFiles = try await downloadFiles(urls: presignedURLs)
            downloadProgress = 0.7

            // Step 3: Create markdown file (10% of progress)
            let markdownData = taskWithFiles.task.markdown.data(using: .utf8) ?? Data()
            downloadProgress = 0.8

            // Step 4: Create ZIP archive (20% of progress)
            let zipURL = try await createZipArchive(
                files: downloadedFiles,
                markdownContent: markdownData,
                taskTitle: taskWithFiles.task.title,
            )
            downloadProgress = 1.0

            // Step 5: Present share sheet
            shareURL = zipURL
            showingShareSheet = true

        } catch {
            viewModel.errorMessage = "Download failed: \(error.localizedDescription)"
        }

        isDownloading = false
    }

    private func downloadFiles(urls: [URL]) async throws -> [(data: Data, name: String)] {
        try await withThrowingTaskGroup(of: (Data, String).self) { group in
            for (index, url) in urls.enumerated() {
                group.addTask {
                    let (data, response) = try await URLSession.shared.data(from: url)

                    // Extract filename from URL or response
                    var filename = "file_\(index)"
                    if let suggestedFilename = response.suggestedFilename {
                        filename = suggestedFilename
                    } else if let lastComponent = url.pathComponents.last,
                              !lastComponent.isEmpty, lastComponent != "/"
                    {
                        filename = lastComponent
                    }

                    return (data, filename)
                }
            }

            var results: [(Data, String)] = []
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }

    private func createZipArchive(
        files: [(data: Data, name: String)],
        markdownContent: Data,
        taskTitle: String,
    ) async throws -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let zipURL = tempDirectory.appendingPathComponent("\(taskTitle).zip")

        // Remove existing file if it exists
        try? FileManager.default.removeItem(at: zipURL)

        // Write markdown file to temp directory
        let markdownURL = tempDirectory.appendingPathComponent("\(taskTitle).md")
        try markdownContent.write(to: markdownURL)

        // Write all other files to temp directory and collect their paths
        var filePaths: [String] = [markdownURL.path]

        for file in files {
            let fileURL = tempDirectory.appendingPathComponent(file.name)
            try file.data.write(to: fileURL)
            filePaths.append(fileURL.path)
        }

        // Create ZIP archive with all files at once
        guard SSZipArchive.createZipFile(atPath: zipURL.path, withFilesAtPaths: filePaths) else {
            throw DownloadError.zipCreationFailed
        }

        return zipURL
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

#Preview {
    NavigationStack {
        TaskDetailView()
    }
}
