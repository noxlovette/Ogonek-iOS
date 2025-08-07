//
//  LessonDetailView.swift
//  Ogonek
//

import MarkdownUI
import SwiftUI

struct LessonDetailView: View {
    let lessonID: String

    @State private var viewModel = LessonDetailViewModel()
    @State private var isDownloading = false
    @State private var downloadProgress = 0.0
    @State private var showingShareSheet = false
    @State private var shareURL = URL(string: "")

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.lesson.topic)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Created \(viewModel.lesson.createdAt.formatted(.relative(presentation: .named)))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Divider()
                    .padding(.vertical, 16)

                VStack(alignment: .leading, spacing: 16) {
                    Markdown(viewModel.lesson.markdown)
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.lesson.topic)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            bottomToolbar
        }
        .sheet(isPresented: $showingShareSheet) {
            if let shareURL {
                ShareSheet(items: [shareURL])
            }
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
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchLesson(id: lessonID)
                }
            }
            Button("Cancel", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let message = viewModel.errorMessage {
                Text(message)
            }
        }
        .task {
            await viewModel.fetchLesson(id: lessonID)
        }
    }

    // MARK: - Private Views

    private func lessonContent(lesson: Lesson) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header section
                VStack(alignment: .leading, spacing: 12) {
                    Text(lesson.topic)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    HStack {
                        Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Divider()
                    .padding(.vertical, 16)

                // Content section
                VStack(alignment: .leading, spacing: 16) {
                    Markdown(lesson.markdown)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(lesson.topic)
    }

    private var bottomToolbar: some View {
        HStack(spacing: 16) {
            Button(action: downloadLesson) {
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
            .disabled(isDownloading)
        }
        .padding()
        .background(.regularMaterial, ignoresSafeAreaEdges: .bottom)
    }

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

    // MARK: Actions

    private func downloadLesson() {
        Task {
            await performDownload()
        }
    }

    // MARK: Export

    @MainActor
    private func performDownload() async {
        isDownloading = true
        downloadProgress = 0.0

        do {
            // Step 1: Extract markdown from lesson data (50% of progress)
            downloadProgress = 0.5
            let markdownContent = viewModel.lesson.markdown

            // Step 2: Create markdown file (50% of progress)
            let markdownURL = try await createMarkdownFile(
                markdownContent: markdownContent,
                lessonTitle: viewModel.lesson.topic,
            )
            downloadProgress = 1.0

            // Step 3: Present share sheet
            shareURL = markdownURL
            showingShareSheet = true

        } catch {
            viewModel.errorMessage = "Export failed: \(error.localizedDescription)"
        }

        isDownloading = false
    }

    // Helper function to create markdown file
    private func createMarkdownFile(
        markdownContent: String,
        lessonTitle: String,
    ) async throws -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let sanitizedTitle = lessonTitle.replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "/", with: "-")
        let markdownURL = tempDirectory.appendingPathComponent("\(sanitizedTitle).md")

        // Remove existing file if it exists
        try? FileManager.default.removeItem(at: markdownURL)

        // Convert string to data and write to file
        guard let markdownData = markdownContent.data(using: .utf8) else {
            throw DownloadError.markdownConversionFailed
        }

        try markdownData.write(to: markdownURL)

        return markdownURL
    }
}

#Preview {
    NavigationStack {
        LessonDetailView(lessonID: "mock")
    }
}
