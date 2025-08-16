//
//  Alias+Lesson.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

typealias Lesson = Components.Schemas.LessonFull
typealias LessonSmall = Components.Schemas.LessonSmall

typealias PaginatedLessons = Components.Schemas.PaginatedLessons
extension Lesson: Identifiable {}
extension LessonSmall: Identifiable {}

extension Lesson {
    static let placeholder = Lesson(
        assignee: "Bc3JW7pm1Zh450ty95fAI",
        assigneeName: "Natasha",
        createdAt: Date(timeIntervalSinceNow: -1000),
        createdBy: "user",
        id: "placeholder",
        markdown: "# Loading...",
        title: "Loading...",
        topic: "Loading...",
        updatedAt: Date(),
    )
}
