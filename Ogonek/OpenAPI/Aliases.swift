//
//  Types.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

    // 1. LESSONS
typealias Lesson = Components.Schemas.LessonFull
typealias LessonSmall = Components.Schemas.LessonSmall
typealias LessonUpdate = Components.Schemas.LessonUpdate

    // 2. TASKS
    // From your schema: TaskFull, TaskSmall, TaskUpdate
typealias Task = Components.Schemas.TaskWithFilesResponse
typealias TaskSmall = Components.Schemas.TaskSmall
typealias TaskUpdate = Components.Schemas.TaskUpdate
typealias File = Components.Schemas.FileSmall

    // 3. DECKS
    // From your schema: DeckFull, DeckSmall, DeckPublic
typealias DeckWithCards = Components.Schemas.DeckWithCardsAndSubscription
typealias Deck = Components.Schemas.DeckFull
typealias DeckSmall = Components.Schemas.DeckSmall
typealias DeckPublic = Components.Schemas.DeckPublic
typealias Card = Components.Schemas.Card

    // 4. USERS & AUTH
typealias User = Components.Schemas.User
typealias AuthPayload = Components.Schemas.AuthPayload
typealias TokenPair = Components.Schemas.TokenPair
typealias RefreshTokenPayload = Components.Schemas.RefreshTokenPayload

    // 5. RESPONSES (Paginated)
typealias PaginatedLessons = Components.Schemas.PaginatedResponseLessonSmall
typealias PaginatedTasks = Components.Schemas.PaginatedResponseTaskSmall
typealias PaginatedDecks = [Components.Schemas.DeckSmall]

    // 6. DASHBOARD DATA
typealias DashboardData = Components.Schemas.DashboardData

// 7. Generics
typealias CreationID = Components.Schemas.CreationId

