//
//  Authentication.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation
import CoreDataStack
import MastodonSDK

public struct OgonekAuthentication: Codable, Hashable, UserIdentifier {

    public static let fallbackCharactersReservedPerURL = 23

    public enum InstanceConfiguration: Codable, Hashable {
        case v1(Mastodon.Entity.Instance)
        case v2(Mastodon.Entity.V2.Instance, TranslationLanguages)

        public func canTranslateFrom(_ sourceLocale: String, to targetLanguage: String) -> Bool {
            switch self {
                case .v1:
                    return false
                case let .v2(instance, translationLanguages):
                    guard instance.configuration?.translation?.enabled == true else { return false }
                    return translationLanguages[sourceLocale]?.contains(targetLanguage) == true
            }
        }

        public var instanceConfigLimitingProperties: InstanceConfigLimitingPropertyContaining? {
            switch self {
                case let .v1(instance):
                    return instance.configuration
                case let .v2(instance, _):
                    return instance.configuration
            }
        }

        public var canFollowTags: Bool {
            let version: String?
            switch self {
                case let .v1(instance):
                    version = instance.version
                case let .v2(instance, _):
                    version = instance.version
            }
            return version?.majorServerVersion(greaterThanOrEquals: 4) ?? false // following Tags is support beginning with Mastodon v4.0.0
        }

        public var canGroupNotifications: Bool {
            switch self {
                case let .v1(_):
                    return false
                case let .v2(instance, _):
                    guard let apiVersion = instance.apiVersions?["mastodon"] else { return false }
                    return apiVersion >= 2
            }
        }

        public var charactersReservedPerURL: Int {
            switch self {
                case let .v1(instance):
                    return instance.configuration?.statuses?.charactersReservedPerURL ?? fallbackCharactersReservedPerURL
                case let .v2(instance, _):
                    return instance.configuration?.statuses?.charactersReservedPerURL ?? fallbackCharactersReservedPerURL
            }
        }
    }

    public typealias ID = UUID

    public let identifier: ID
    public let domain: String
    public let username: String

    public let appAccessToken: String
    public let userAccessToken: String
    public let clientID: String
    public let clientSecret: String

    public let createdAt: Date
    public let updatedAt: Date
    public let activedAt: Date

    public let userID: String

    public let instanceConfiguration: InstanceConfiguration?
    public let accountCreatedAt: Date?

    public var persistenceIdentifier: String {
        "\(username)@\(domain)"
    }

    public static func createFrom(
        domain: String,
        userID: String,
        username: String,
        appAccessToken: String,
        userAccessToken: String,
        clientID: String,
        clientSecret: String,
        accountCreatedAt: Date
    ) -> Self {
        let now = Date()
        Task {
            await InstanceService.shared.updateInstance(domain: domain)
        }
        return MastodonAuthentication(
            identifier: .init(),
            domain: domain,
            username: username,
            appAccessToken: appAccessToken,
            userAccessToken: userAccessToken,
            clientID: clientID,
            clientSecret: clientSecret,
            createdAt: now,
            updatedAt: now,
            activedAt: now,
            userID: userID,
            instanceConfiguration: nil,
            accountCreatedAt: accountCreatedAt
        )
    }

    func copy(
        identifier: ID? = nil,
        domain: String? = nil,
        username: String? = nil,
        appAccessToken: String? = nil,
        userAccessToken: String? = nil,
        clientID: String? = nil,
        clientSecret: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        activedAt: Date? = nil,
        accountCreatedAt: Date? = nil,
        userID: String? = nil,
        instanceConfiguration: InstanceConfiguration? = nil
    ) -> Self {
        MastodonAuthentication(
            identifier: identifier ?? self.identifier,
            domain: domain ?? self.domain,
            username: username ?? self.username,
            appAccessToken: appAccessToken ?? self.appAccessToken,
            userAccessToken: userAccessToken ?? self.userAccessToken,
            clientID: clientID ?? self.clientID,
            clientSecret: clientSecret ?? self.clientSecret,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            activedAt: activedAt ?? self.activedAt,
            userID: userID ?? self.userID,
            instanceConfiguration: instanceConfiguration ?? self.instanceConfiguration,
            accountCreatedAt: accountCreatedAt ?? self.accountCreatedAt
        )
    }

    @MainActor
    public func cachedAccount() -> Mastodon.Entity.Account? {
        return PersistenceManager.shared.cachedAccount(for: self)
    }

    public func userIdentifier() -> MastodonUserIdentifier {
        MastodonUserIdentifier(domain: domain, userID: userID)
    }

    @MainActor
    func updating(instanceV1 instance: Mastodon.Entity.Instance) -> Self {
        return copy(instanceConfiguration: .v1(instance))
    }

    @MainActor
    func updating(instanceV2 instance: Mastodon.Entity.V2.Instance) -> Self {
        guard
            let instanceConfiguration,
            case let InstanceConfiguration.v2(_, translationLanguages) = instanceConfiguration
        else {
            return copy(instanceConfiguration: .v2(instance, [:]))
        }
        return copy(instanceConfiguration: .v2(instance, translationLanguages))
    }

    @MainActor
    func updating(translationLanguages: TranslationLanguages) -> Self {
        switch self.instanceConfiguration {
            case .v1(let instance):
                return copy(instanceConfiguration: .v1(instance))
            case .v2(let instance, _):
                return copy(instanceConfiguration: .v2(instance, translationLanguages))
            case .none:
                return self
        }
    }

    func updating(activatedAt: Date) -> Self {
        copy(activedAt: activatedAt)
    }

    func updating(accountCreatedAt: Date) -> Self {
        copy(accountCreatedAt: accountCreatedAt)
    }

    var authorization: Mastodon.API.OAuth.Authorization {
        .init(accessToken: userAccessToken)
    }
}
