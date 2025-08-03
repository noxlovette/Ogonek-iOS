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
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LessonRowView(lesson: MockData.paginatedLessons.data[0])
}
