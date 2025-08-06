//
//  FilesView.swift
//  Ogonek
//
//  Created by Danila Volkov on 06.08.2025.
//

import SwiftUI

struct FilesView: View {
    let files: [File]

    var body: some View {
        NavigationView {
            Group {
                if files.isEmpty {
                    emptyStateView
                } else {
                    filesList
                }
            }
            .navigationTitle("Attached Files")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Views

    private var filesList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(files) { file in
                    FileRow(file: file)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No Files Attached")
                .font(.headline)
                .foregroundColor(.primary)

            Text("This task doesn't have any files attached to it yet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

struct FileRow: View {
    let file: File

    var body: some View {
        HStack(spacing: 16) {
            // File icon
            fileIcon
                .frame(width: 40, height: 40)

            // File details
            VStack(alignment: .leading, spacing: 4) {
                Text(file.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                HStack {
                    if let mimeType = file.mimeType {
                        Text(fileTypeLabel(from: mimeType))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(.tertiarySystemFill)),
                            )
                    }

                    Spacer()

                    Text(formatFileSize(file.size))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            // Visual indicator that it's not clickable
            Image(systemName: "eye")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1),
        )
    }

    // MARK: - File Icon

    private var fileIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(fileIconColor)

            Image(systemName: fileIconName)
                .font(.title3)
                .foregroundColor(.white)
        }
    }

    private var fileIconColor: Color {
        guard let mimeType = file.mimeType else { return .gray }

        switch mimeType {
        case let type where type.hasPrefix("image/"):
            return .orange
        case let type where type.hasPrefix("video/"):
            return .purple
        case let type where type.hasPrefix("audio/"):
            return .pink
        case let type where type.contains("pdf"):
            return .red
        case let type where type.contains("document") || type.contains("word"):
            return .blue
        case let type where type.contains("spreadsheet") || type.contains("excel"):
            return .green
        case let type where type.contains("presentation") || type.contains("powerpoint"):
            return .indigo
        case let type where type.contains("zip") || type.contains("archive"):
            return .brown
        default:
            return .gray
        }
    }

    private var fileIconName: String {
        guard let mimeType = file.mimeType else { return "doc" }

        switch mimeType {
        case let type where type.hasPrefix("image/"):
            return "photo"
        case let type where type.hasPrefix("video/"):
            return "video"
        case let type where type.hasPrefix("audio/"):
            return "music.note"
        case let type where type.contains("pdf"):
            return "doc.text"
        case let type where type.contains("document") || type.contains("word"):
            return "doc.text"
        case let type where type.contains("spreadsheet") || type.contains("excel"):
            return "tablecells"
        case let type where type.contains("presentation") || type.contains("powerpoint"):
            return "rectangle.on.rectangle"
        case let type where type.contains("zip") || type.contains("archive"):
            return "archivebox"
        default:
            return "doc"
        }
    }

    // MARK: - Helper Functions

    private func fileTypeLabel(from mimeType: String) -> String {
        switch mimeType {
        case let type where type.hasPrefix("image/"):
            "Image"
        case let type where type.hasPrefix("video/"):
            "Video"
        case let type where type.hasPrefix("audio/"):
            "Audio"
        case let type where type.contains("pdf"):
            "PDF"
        case let type where type.contains("document") || type.contains("word"):
            "Document"
        case let type where type.contains("spreadsheet") || type.contains("excel"):
            "Spreadsheet"
        case let type where type.contains("presentation") || type.contains("powerpoint"):
            "Presentation"
        case let type where type.contains("zip") || type.contains("archive"):
            "Archive"
        case let type where type.hasPrefix("text/"):
            "Text"
        default:
            "File"
        }
    }

    private func formatFileSize(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: bytes)
    }
}

#Preview {
    FilesView(files: MockData.taskWithFiles.files)
}
