//
//  User.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension Ogonek.Entity.User {
        public typealias ID = String
}

extension Ogonek.Entity.User {
    public final class Role: Codable, Sendable {
        public let id: String
        public let name: String
        public let color: String
        public let permissions: String // To determine the permissions available to a certain role, convert the permissions attribute to binary and compare from the least significant bit upwards.
        public let highlighted: Bool

        public func rolePermissions() -> Permissions {
            guard let rawValue = UInt32(permissions) else { return [] }
            return Permissions(rawValue: rawValue)
        }

        public struct Permissions: OptionSet {
            public let rawValue: UInt32

            public init(rawValue: UInt32) {
                self.rawValue = rawValue
            }

            public static let administrator = Permissions(rawValue: 1 << 0)
            public static let devops = Permissions(rawValue: 1 << 1)
            public static let viewAuditLog = Permissions(rawValue: 1 << 2)
            public static let viewDashboard = Permissions(rawValue: 1 << 3)

            public static let manageReports = Permissions(rawValue: 1 << 4)
            public static let manageFederation = Permissions(rawValue: 1 << 5)
            public static let manageSettings = Permissions(rawValue: 1 << 6)
            public static let manageBlocks = Permissions(rawValue: 1 << 7)

            public static let manageTaxonomies = Permissions(rawValue: 1 << 8)
            public static let manageAppeals = Permissions(rawValue: 1 << 9)
            public static let manageUsers = Permissions(rawValue: 1 << 10)
            public static let manageInvites = Permissions(rawValue: 1 << 11)

            public static let manageRules = Permissions(rawValue: 1 << 12)
            public static let manageAnnouncements = Permissions(rawValue: 1 << 13)
            public static let manageCustomEmojis = Permissions(rawValue: 1 << 14)
            public static let manageWebhooks = Permissions(rawValue: 1 << 15)

            public static let inviteUsers = Permissions(rawValue: 1 << 16)
            public static let manageRoles = Permissions(rawValue: 1 << 17)
            public static let manageUserAccess = Permissions(rawValue: 1 << 18)
            public static let deleteUserData = Permissions(rawValue: 1 << 19)
        }
    }
}
