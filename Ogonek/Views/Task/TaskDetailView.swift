import MarkdownUI
import SwiftUI
import UniformTypeIdentifiers
import ZipArchive

struct TaskDetailView: View {
    let taskID: String
    @State private var showingFileUpload: Bool = false
    @State var isDownloading = false
    @State private var downloadProgress: Double = 0.0
    @State private var shareURL: URL?
    @State var viewModel = TaskDetailViewModel()
    @State private var showingShareSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Markdown(viewModel.taskWithFiles.task.markdown)
            }
            .padding()
        }
        .navigationTitle(viewModel.taskWithFiles.task.title)
        .toolbar {
            toolbarContent()
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
        }
        .overlay {
            if isDownloading {
                downloadOverlay
            }
        }
        .sheet(isPresented: $showingFileUpload) {
            FilesView(files: viewModel.taskWithFiles.files)
        }

        .sheet(isPresented: $showingShareSheet) {
            if let shareURL {
                ShareSheet(items: [shareURL])
            }
        }

        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchTask(id: taskID)
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
        .task {
            await viewModel.fetchTask(id: taskID)
        }
    }
}

extension TaskDetailView {
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

    func downloadTask() {
        Task {
            await performDownload()
        }
    }

    func markAsComplete() {
        Task {
            await viewModel.toggleTaskCompletion(id: taskID)
            await viewModel.fetchTask(id: taskID)
        }
    }

    @MainActor
    private func performDownload() async {
        isDownloading = true
        downloadProgress = 0.0

        do {
            downloadProgress = 0.1
            let presignedURLs = try await viewModel.getPresignedURLs(
                for: taskID,
            )

            downloadProgress = 0.2
            let downloadedFiles = try await downloadFiles(urls: presignedURLs)
            downloadProgress = 0.7

            let markdownData = viewModel.taskWithFiles.task.markdown.data(using: .utf8) ?? Data()
            downloadProgress = 0.8

            let zipURL = try await createZipArchive(
                files: downloadedFiles,
                markdownContent: markdownData,
                taskTitle: viewModel.taskWithFiles.task.title,
            )
            downloadProgress = 1.0

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

        try? FileManager.default.removeItem(at: zipURL)

        let markdownURL = tempDirectory.appendingPathComponent("\(taskTitle).md")
        try markdownContent.write(to: markdownURL)

        var filePaths: [String] = [markdownURL.path]

        for file in files {
            let fileURL = tempDirectory.appendingPathComponent(file.name)
            try file.data.write(to: fileURL)
            filePaths.append(fileURL.path)
        }

        guard SSZipArchive.createZipFile(atPath: zipURL.path, withFilesAtPaths: filePaths) else {
            throw DownloadError.zipCreationFailed
        }

        return zipURL
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(taskID: "mock")
    }
}
