import Foundation

protocol LessonRepository {
    func getLessons() async throws -> [Lesson]
    func getLesson(id: String) async throws -> Lesson
}

protocol TaskRepository {
    func getTasks() async throws -> [Assignment]
    func getTask(id: String) async throws -> Assignment
}

protocol DeckRepository {
    func getDecks() async throws -> [Deck]
    func getDeck(id: String) async throws -> Deck
}

class APILessonRepository: LessonRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getLessons() async throws -> [Lesson] {
        let response: LessonResponse = try await apiService.fetch(LessonResponse.self, from: "lesson")
        return response.data
    }

    func getLesson(id: String) async throws -> Lesson {
        return try await apiService.fetch(Lesson.self, from: "lesson/l/\(id)")
    }
}

class APITaskRepository: TaskRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getTasks() async throws -> [Assignment] {
        let response: TaskResponse = try await apiService.fetch(
            TaskResponse.self,
            from: "task"
        )
        return response.data
    }

    func getTask(id: String) async throws -> Assignment {
        return try await apiService.fetch(Assignment.self, from: "task/t/\(id)")
    }
}

class APIDeckRepository: DeckRepository {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func getDecks() async throws -> [Deck] {
        let response: [Deck] = try await apiService.fetch([Deck].self, from: "words")
        return response
    }

    func getDeck(id: String) async throws -> Deck {
        return try await apiService.fetch(Deck.self, from: "words/w/\(id)")
    }
}
