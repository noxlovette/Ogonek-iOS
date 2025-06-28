//
//  LessonDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 29.04.2025.
//
import SwiftUI
import MarkdownUI

struct LessonDetail: View {
    let lesson: Lesson

    var body: some View {
        ScrollView {
            
        
        VStack(alignment: .leading, spacing: 16) {
            Text(lesson.topic)
                .font(.title)
                .bold()

            Text("\(lesson.createdAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()

            Markdown(lesson.markdown)
                .padding(.top, 8)

            Spacer()
        }
        .padding()
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.inline)
    }
    }
}

#Preview {
    NavigationView {
        LessonDetail(lesson: Lesson.preview)
    }
}
