//
//  UserIdentifier.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public protocol UserIdentifier {
    var domain: String { get }
    var userID: Mastodon.Entity.Account.ID { get }
}

public extension UserIdentifier {
    var globallyUniqueUserIdentifier: String {
        "\(userID)@\(domain)"
    }
}

public struct MastodonUserIdentifier: UserIdentifier {
    public let domain: String
    public var userID: Mastodon.Entity.Account.ID


    public init(
        domain: String,
        userID: Mastodon.Entity.Account.ID
    ) {
        self.domain = domain
        self.userID = userID
    }

    public init(authenticationBox: MastodonAuthenticationBox) {
        self.domain = authenticationBox.domain
        self.userID = authenticationBox.userID
    }
}
