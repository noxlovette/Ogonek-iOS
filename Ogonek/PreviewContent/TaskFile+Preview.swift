//
//  TaskFile+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

extension TaskFile {
    static var preview: TaskFile {
        TaskFile(
            id: "file001",
            name: "Example.pdf",
            url: "https://example.com/files/example.pdf",
            size: 1_048_576, // 1 MB
            mimeType: "application/pdf"
        )
    }

    static var previewSet: [TaskFile] {
        [
            TaskFile(
                id: "file002",
                name: "Notes.txt",
                url: "https://example.com/files/notes.txt",
                size: 2048,
                mimeType: "text/plain"
            ),
            TaskFile(
                id: "file003",
                name: "Presentation.pptx",
                url: "https://example.com/files/presentation.pptx",
                size: 5_242_880, // 5 MB
                mimeType: "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            ),
            TaskFile(
                id: "file004",
                name: "Diagram.png",
                url: "https://example.com/files/diagram.png",
                size: 512_000,
                mimeType: "image/png"
            ),
            TaskFile(
                id: "file005",
                name: "AudioNote.m4a",
                url: "https://example.com/files/audionote.m4a",
                size: 3_145_728,
                mimeType: "audio/mp4"
            ),
            TaskFile.preview,
        ]
    }
}
