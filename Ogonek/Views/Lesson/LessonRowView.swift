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
        NavigationLink {
            LessonDetailView(lessonId: lesson.id)
        } label: {
            VStack {
                Text(lesson.topic)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)

                HStack {
                    Image(systemName: "clock")
                        .font(.caption2)
                        .foregroundColor(.secondary)

                    Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
        }
    }
}

#Preview("Lesson Row View") {
        LessonRowView(lesson: MockData.paginatedLessons.data[0])
}
