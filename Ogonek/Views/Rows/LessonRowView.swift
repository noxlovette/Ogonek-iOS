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
            LessonDetailView(lessonID: lesson.id)
        } label: {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(lesson.topic)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LessonRowView(lesson: MockData.paginatedLessons.data[0])
}
