//
//  Aliases.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

typealias ActivityLog = Components.Schemas.ActivityLog
typealias AuthPayload = Components.Schemas.AuthPayload
typealias TokenPair = Components.Schemas.TokenPair
typealias RefreshTokenPayload = Components.Schemas.RefreshTokenPayload

typealias DashboardData = Components.Schemas.DashboardData
typealias NotificationBadges = Components.Schemas.NotificationBadges
typealias AppContext = Components.Schemas.AppContext
typealias Preferences = Components.Schemas.UserPreferences

extension NotificationBadges {
    init() {
        unseenDecks = 0
        unseenTasks = 0
        unseenLessons = 0
    }
}

extension AppContext {
    init() {
        callUrl = ""
        students = []
        preferences = Preferences()
        user = User()
        profile = Profile()
    }
}

extension User {
    init() {
        id = ""
        username = ""
        email = ""
        role = "student"
        name = ""
    }
}

extension Profile {
    init() {
        userId = ""
        videoCallUrl = nil
        avatarUrl = nil
        telegramId = nil
    }
}

extension Preferences {
    init() {
        autoSubscribe = true
        emailNotifications = true
        pushNotifications = true
        theme = "light"
        language = "en"
    }
}
