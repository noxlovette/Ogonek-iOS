//
//  LessonRowView.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import SwiftUI

struct LessonRowView: View {
    let lesson: LessonSmall

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(lesson.topic)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)

            HStack {
                Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                // Status indicator or additional info could go here
                Image(systemName: "book.fill")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}
