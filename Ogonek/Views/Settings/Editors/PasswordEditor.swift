import SwiftUI

struct PasswordValidation {
    let hasMinLength: Bool
    let hasUppercase: Bool
    let hasLowercase: Bool
    let hasNumber: Bool
    let hasSpecialChar: Bool

    var isValid: Bool {
        hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar
    }

    var strength: PasswordStrength {
        let validCriteria = [hasMinLength, hasUppercase, hasLowercase, hasNumber, hasSpecialChar].filter { $0 }.count

        switch validCriteria {
        case 0...1: return .weak
        case 2...3: return .fair
        case 4: return .good
        case 5: return .strong
        default: return .weak
        }
    }

    static func validate(_ password: String) -> PasswordValidation {
        return PasswordValidation(
            hasMinLength: password.count >= 8,
            hasUppercase: password.contains { $0.isUppercase },
            hasLowercase: password.contains { $0.isLowercase },
            hasNumber: password.contains { $0.isNumber },
            hasSpecialChar: password.contains { "!@#$%^&*()_+-=[]{}|;:,.<>?".contains($0) }
        )
    }
}

enum PasswordStrength: CaseIterable {
    case weak, fair, good, strong

    var color: Color {
        switch self {
        case .weak: return .red
        case .fair: return .orange
        case .good: return .yellow
        case .strong: return .green
        }
    }

    var text: String {
        switch self {
        case .weak: return "Weak"
        case .fair: return "Fair"
        case .good: return "Good"
        case .strong: return "Strong"
        }
    }
}

struct PasswordStrengthIndicator: View {
    let strength: PasswordStrength

    var body: some View {
        HStack(spacing: 4) {
            ForEach(PasswordStrength.allCases, id: \.self) { level in
                Rectangle()
                    .fill(strengthColor(for: level))
                    .frame(height: 4)
                    .cornerRadius(2)
            }
        }
    }

    private func strengthColor(for level: PasswordStrength) -> Color {
        let currentIndex = PasswordStrength.allCases.firstIndex(of: strength) ?? 0
        let levelIndex = PasswordStrength.allCases.firstIndex(of: level) ?? 0

        return levelIndex <= currentIndex ? strength.color : Color(.systemGray5)
    }
}

struct PasswordCriteriaRow: View {
    let text: String
    let isMet: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isMet ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isMet ? .green : .secondary)
                .font(.caption)

            Text(text)
                .font(.caption)
                .foregroundColor(isMet ? .primary : .secondary)

            Spacer()
        }
        .animation(.easeInOut(duration: 0.2), value: isMet)
    }
}

struct PasswordEditor: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswords: Bool = false
    @State private var showValidation: Bool = false
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case newPassword, confirmPassword
    }

    private var validation: PasswordValidation {
        PasswordValidation.validate(newPassword)
    }

    private var passwordsMatch: Bool {
        !newPassword.isEmpty && !confirmPassword.isEmpty && newPassword == confirmPassword
    }

    private var canSave: Bool {
        validation.isValid && passwordsMatch
    }

    var body: some View {
        NavigationStack {
            Form {
                passwordFieldsSection

                if !newPassword.isEmpty {
                    passwordStrengthSection
                    passwordCriteriaSection
                }

                if !confirmPassword.isEmpty && !passwordsMatch {
                    passwordMatchSection
                }

                settingsSection
            }
            .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        savePassword()
                    }
                    .disabled(!canSave)
                    .fontWeight(.semibold)
                }
            }
        }
    }

    private var passwordFieldsSection: some View {
        Section {
            Group {
                if showPasswords {
                    TextField("New Password", text: $newPassword)
                        .focused($focusedField, equals: .newPassword)
                } else {
                    SecureField("New Password", text: $newPassword)
                        .focused($focusedField, equals: .newPassword)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .submitLabel(.next)
            .onSubmit {
                focusedField = .confirmPassword
            }
            .onChange(of: newPassword) { _, _ in
                showValidation = !newPassword.isEmpty
            }

            Group {
                if showPasswords {
                    TextField("Confirm Password", text: $confirmPassword)
                        .focused($focusedField, equals: .confirmPassword)
                } else {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .focused($focusedField, equals: .confirmPassword)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .submitLabel(.done)
            .onSubmit {
                if canSave {
                    savePassword()
                }
            }
        } header: {
            Text("Password")
        }
    }

    private var passwordStrengthSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Password Strength:")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text(validation.strength.text)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(validation.strength.color)
                }

                PasswordStrengthIndicator(strength: validation.strength)
            }
        }
    }

    private var passwordCriteriaSection: some View {
        Section {
            VStack(spacing: 6) {
                PasswordCriteriaRow(
                    text: "At least 8 characters",
                    isMet: validation.hasMinLength
                )

                PasswordCriteriaRow(
                    text: "Contains uppercase letter",
                    isMet: validation.hasUppercase
                )

                PasswordCriteriaRow(
                    text: "Contains lowercase letter",
                    isMet: validation.hasLowercase
                )

                PasswordCriteriaRow(
                    text: "Contains number",
                    isMet: validation.hasNumber
                )

                PasswordCriteriaRow(
                    text: "Contains special character (!@#$%^&*)",
                    isMet: validation.hasSpecialChar
                )
            }
        } header: {
            Text("Requirements")
        }
    }

    private var passwordMatchSection: some View {
        Section {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.caption)

                Text("Passwords do not match")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    private var settingsSection: some View {
        Section {
            Toggle("Show Passwords", isOn: $showPasswords)
        } header: {
            Text("Display")
        }
    }

    private func savePassword() {
        guard validation.isValid && passwordsMatch else { return }

            try await APIService.shared.updateAccount(password: newPassword)

            dismiss()
        } catch {
            errorMessage = "Failed to update password: \(error.localizedDescription)"
            showError = true
        }

        isLoading = false
    }
}

@Observable
class PasswordEditorViewModel: BaseViewModel {
    @MainActor
    func savePassword(_ password: String) {
        isLoading = true
        errorMessage = nil

        do {
            try await APIService.shared.updateAccount(password: password)
        } catch {
          handleError(error)
        }

        isLoading = false
    }

}

#Preview {
    PasswordEditor()
}
