//
//  Aliases.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension Ogonek.Entity {
        // 2. TASKS
    typealias Task = Components.Schemas.TaskWithFilesResponse
    // typealias TaskUpdate = Components.Schemas.TaskUpdate
    typealias File = Components.Schemas.FileSmall
    typealias TaskSmall = Components.Schemas.PaginatedResponseTaskSmall.DataPayloadPayload

        // 3. DECKS
    typealias DeckWithCards = Components.Schemas.DeckWithCardsAndSubscription
    typealias Deck = Components.Schemas.DeckFull
    typealias DeckSmall = Components.Schemas.DeckSmall
    // typealias DeckPublic = Components.Schemas.DeckPublic
    typealias Card = Components.Schemas.Card
    extension Card: Identifiable {}

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

    // 8. User Data
    typealias Profile = Components.Schemas.Profile
    typealias User = Components.Schemas.User
    typealias Dashboard = Components.Schemas.DashboardData
}
