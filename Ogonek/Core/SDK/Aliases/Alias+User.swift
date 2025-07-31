//
//  Alias+User.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension User {
    typealias ID = String
}

extension User {
    final class Role: Codable, Sendable {
        let id: String
        let name: String
        let color: String
        let permissions: String // To determine the permissions available to a certain role, convert the permissions attribute to binary and compare from the least significant bit upwards.
        let highlighted: Bool

        func rolePermissions() -> Permissions {
            guard let rawValue = UInt32(permissions) else { return [] }
            return Permissions(rawValue: rawValue)
        }

        struct Permissions: OptionSet {
            let rawValue: UInt32

            init(rawValue: UInt32) {
                self.rawValue = rawValue
            }

            static let administrator = Permissions(rawValue: 1 << 0)
            static let devops = Permissions(rawValue: 1 << 1)
            static let viewAuditLog = Permissions(rawValue: 1 << 2)
            static let viewDashboard = Permissions(rawValue: 1 << 3)

            static let manageReports = Permissions(rawValue: 1 << 4)
            static let manageFederation = Permissions(rawValue: 1 << 5)
            static let manageSettings = Permissions(rawValue: 1 << 6)
            static let manageBlocks = Permissions(rawValue: 1 << 7)

            static let manageTaxonomies = Permissions(rawValue: 1 << 8)
            static let manageAppeals = Permissions(rawValue: 1 << 9)
            static let manageUsers = Permissions(rawValue: 1 << 10)
            static let manageInvites = Permissions(rawValue: 1 << 11)

            static let manageRules = Permissions(rawValue: 1 << 12)
            static let manageAnnouncements = Permissions(rawValue: 1 << 13)
            static let manageCustomEmojis = Permissions(rawValue: 1 << 14)
            static let manageWebhooks = Permissions(rawValue: 1 << 15)

            static let inviteUsers = Permissions(rawValue: 1 << 16)
            static let manageRoles = Permissions(rawValue: 1 << 17)
            static let manageUserAccess = Permissions(rawValue: 1 << 18)
            static let deleteUserData = Permissions(rawValue: 1 << 19)
        }
    }
}
