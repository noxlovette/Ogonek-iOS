//
//  UserIdentifier.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public protocol UserIdentifier {
    var role: String { get }
    var userID: Ogonek.Entity.User.ID { get }
}

public extension UserIdentifier {
    var globallyUniqueUserIdentifier: String {
        "\(userID)@\(role)"
    }
}

public struct OgonekUserIdentifier: UserIdentifier {
    public let role: String
    public var userID: Mastodon.Entity.Account.ID

    public init(
        role: String,
        userID: Mastodon.Entity.Account.ID
    ) {
        self.role = role
        self.userID = userID
    }

    public init(authenticationBox: OgonekAuthenticationBox) {
        role = authenticationBox.role
        userID = authenticationBox.userID
    }
}
