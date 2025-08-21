//
//  SettingsView+Account.swift
//  Ogonek
//
//  Created by Danila Volkov on 21.08.2025.
//

import SwiftUI
extension SettingsView {
    var accountSection: some View {
        Section("Account") {
            if let user = appState.context.user {
                NavigationLink {
                    UsernameEditor()
                } label: {
                    HStack {
                        Image(systemName: "person")
                            .foregroundStyle(.blue)
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Username")
                                .font(.body)
                            Text(user.username)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                }

                NavigationLink {
                    EmailEditor()
                } label: {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundStyle(.green)
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Email")
                                .font(.body)
                            Text(user.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                }

                NavigationLink {
                    PasswordEditor()
                } label: {
                    HStack {
                        Image(systemName: "key")
                            .foregroundStyle(.orange)
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Password")
                                .font(.body)
                            Text("••••••••")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                }
            } else {
                    // Show placeholder rows while loading
                ForEach(["Username", "Email", "Password"], id: \.self) { title in
                    HStack {
                        Image(systemName: "person")
                            .foregroundStyle(.secondary)
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(title)
                                .font(.body)
                            Text("Loading...")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                    .redacted(reason: .placeholder)
                }
            }
        }
    }
}
