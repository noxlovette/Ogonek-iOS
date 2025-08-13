//
//  LessonDetailView.swift
//  Ogonek
//

import MarkdownUI
import SwiftUI

struct LessonDetailView: View {
    let lessonID: String

    @State private var viewModel = LessonDetailViewModel()
    @State var isDownloading = false
    @State private var downloadProgress = 0.0
    @State private var showingShareSheet = false
    @State private var shareURL = URL(string: "")

    var body: some View {
        VStack {
            if let lesson = viewModel.lesson {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Markdown(lesson.markdown)
                    }
                    .padding()
                }
                .navigationTitle(lesson.topic)

            } else {
                ProgressView()
            }
        }.toolbar {
            toolbarContent()
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
}

extension LessonDetailView {
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

    func downloadLesson() {
        Task {
            await performDownload()
        }
    }

    @MainActor
    private func performDownload() async {
        isDownloading = true
        downloadProgress = 0.0

        guard let lessonToDownload = viewModel.lesson else {
            isDownloading = false
            return
        }

        do {
            downloadProgress = 0.5
            let markdownContent = lessonToDownload.markdown

            let markdownURL = try await createMarkdownFile(
                markdownContent: markdownContent,
                lessonTitle: lessonToDownload.topic,
            )
            downloadProgress = 1.0

            shareURL = markdownURL
            showingShareSheet = true

        } catch {
            viewModel.errorMessage = "Export failed: \(error.localizedDescription)"
        }

        isDownloading = false
    }

    private func createMarkdownFile(
        markdownContent: String,
        lessonTitle: String,
    ) async throws -> URL {
        let tempDirectory = FileManager.default.temporaryDirectory
        let sanitizedTitle = lessonTitle.replacingOccurrences(of: " ", with: "_")
            .replacingOccurrences(of: "/", with: "-")
        let markdownURL = tempDirectory.appendingPathComponent("\(sanitizedTitle).md")

        try? FileManager.default.removeItem(at: markdownURL)

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
