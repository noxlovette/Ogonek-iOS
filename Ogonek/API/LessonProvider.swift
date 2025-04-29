//
//  QuakesProvider.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation
import Observation


@Observable
class LessonsProvider {
    
    var lessons: [Lesson] = []
    
    let client: LessonClient
    
    func fetchLessons() async throws {
        let latestLessons = try await client.lessons
        self.lessons = latestLessons
    }
    
    func deleteLessons(atOffsets offsets: IndexSet) {
        lessons.remove(atOffsets: offsets)
    }
    
    init(client: LessonClient = LessonClient()) {
        self.client = client
    }
}
