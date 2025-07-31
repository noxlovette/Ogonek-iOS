//
//  AuthenticationBox.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public protocol AuthContextProvider {
    var authenticationBox: OgonekAuthenticationBox { get }
}

public struct OgonekAuthenticationBox: UserIdentifier {
    public let authentication: OgonekAuthentication
    public var role: String { authentication.role }
    public var userID: String { authentication.userID }
    public var appAuthorization: Mastodon.API.OAuth.Authorization {
        Mastodon.API.OAuth.Authorization(accessToken: authentication.appAccessToken)
    }
    public var userAuthorization: Mastodon.API.OAuth.Authorization {
        Mastodon.API.OAuth.Authorization(accessToken: authentication.userAccessToken)
    }

    public init(authentication: OgonekAuthentication) {
        self.authentication = authentication
    }

    @MainActor
    public var cachedAccount: Mastodon.Entity.Account? {
        return authentication.cachedAccount()
    }
}
