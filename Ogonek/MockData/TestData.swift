//
//  TestData.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

// MARK: LESSONS

let testLessonsData: Data = {
    guard let url = Bundle.main.url(forResource: "testLessons", withExtension: "json"),
          let data = try? Data(contentsOf: url)
    else {
        fatalError("Could not load testLessons.json")
    }
    return data
}()!

// MARK: TASKS

let testTasksData: Data = {
    guard let url = Bundle.main.url(forResource: "testTasks", withExtension: "json"),
          let data = try? Data(contentsOf: url)
    else {
        fatalError("Could not load testTasks.json")
    }
    return data
}()

// MARK: DECKS

let testDecksData: Data = {
    guard let url = Bundle.main.url(forResource: "testDecks", withExtension: "json"),
          let data = try? Data(contentsOf: url)
    else {
        fatalError("Could not load testDecks.json")
    }
    return data
}()
