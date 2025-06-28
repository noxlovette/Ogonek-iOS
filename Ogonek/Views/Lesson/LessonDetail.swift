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
        VStack() {
            Markdown(lesson.markdown)
                .padding(.top, 8)

            Spacer()
        }
        .padding()
        .navigationTitle(lesson.topic)
    }
    }
}

#Preview {
    NavigationView {
        LessonDetail(lesson: Lesson.preview)
    }
}
