//
//  Providers.swift
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
        print("Reached logging point")
        let latestLessons = try await client.getLessons()
        print("latest lessons fetch successful")
        lessons = latestLessons
    }

    init(client: LessonClient = LessonClient()) {
        self.client = client
    }
}

@Observable
class TasksProvider {
    var tasks: [Assignment] = []

    let client: TaskClient

    func fetchTasks() async throws {
        let latestTasks = try await client.getTasks()
        tasks = latestTasks
    }

    init(client: TaskClient = TaskClient()) {
        self.client = client
    }
}
