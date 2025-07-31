//
//  Aliases.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation


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
typealias Dashboard = Components.Schemas.DashboardData
