import Foundation
import Observation

@Observable
class AppState {
    // State
    var lessons: [Lesson] = []
    var tasks: [Assignment] = []
    var decks: [Deck] = []

    // Loading states
    var isLoadingLessons = false
    var isLoadingTasks = false
    var isLoadingDecks = false

    // Error states
    var lessonError: Error?
    var taskError: Error?
    var deckError: Error?

    // Dependencies
    private let lessonRepo: LessonRepository
    private let taskRepo: TaskRepository
    private let deckRepo: DeckRepository

    init(lessonRepo: LessonRepository, taskRepo: TaskRepository, deckRepo: DeckRepository) {
        self.lessonRepo = lessonRepo
        self.taskRepo = taskRepo
        self.deckRepo = deckRepo
    }

    // Actions
    @MainActor
    func loadLessons() async {
        isLoadingLessons = true
        lessonError = nil

        do {
            lessons = try await lessonRepo.getLessons()
        } catch {
            lessonError = error
        }

        isLoadingLessons = false
    }

    @MainActor
    func loadTasks() async {
        isLoadingTasks = true
        taskError = nil

        do {
            tasks = try await taskRepo.getTasks()
        } catch {
            taskError = error
        }

        isLoadingTasks = false
    }

    @MainActor
    func loadDecks() async {
        isLoadingDecks = true
        taskError = nil

        do {
            decks = try await deckRepo.getDecks()
        } catch {
            deckError = error
        }

        isLoadingDecks = false
    }

}
