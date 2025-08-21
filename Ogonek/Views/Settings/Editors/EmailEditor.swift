import SwiftUI

// MARK: - Email Validation
struct EmailValidation {
    let isValidFormat: Bool
    let isNotEmpty: Bool

    var isValid: Bool {
        isValidFormat && isNotEmpty
    }

    static func validate(_ email: String) -> EmailValidation {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return EmailValidation(
            isValidFormat: emailPredicate.evaluate(with: email),
            isNotEmpty: !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        )
    }
}

struct EmailEditor: View {
    @Environment(\.dismiss) private var dismiss
    @State private var appState = AppState.shared
    @State private var tempEmail: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var showError: Bool = false
    @FocusState private var isEmailFocused: Bool

    private var validation: EmailValidation {
        EmailValidation.validate(tempEmail)
    }

    private var currentEmail: String {
        appState.context.user.email
    }

    private var hasChanges: Bool {
        tempEmail.trimmingCharacters(in: .whitespacesAndNewlines) != currentEmail && !tempEmail.isEmpty
    }

    private var canSave: Bool {
        validation.isValid && hasChanges && !isLoading
    }

    var body: some View {
        NavigationStack {
            Form {
                emailSection

                if !tempEmail.isEmpty && !validation.isValidFormat {
                    validationSection
                }
            }
            .navigationTitle("Edit Email")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isLoading)
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        Task {
                            await saveEmail()
                        }
                    }
                    .disabled(!canSave)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                tempEmail = currentEmail
                isEmailFocused = true
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") {
                    errorMessage = nil
                }
            } message: {
                if let errorMessage {
                    Text(errorMessage)
                }
            }
            .overlay {
                if isLoading {
                    LoadingOverlay()
                }
            }
        }
    }

    private var emailSection: some View {
        Section {
            TextField("Email Address", text: $tempEmail)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($isEmailFocused)
                .submitLabel(.done)
                .onSubmit {
                    if canSave {
                        Task {
                            await saveEmail()
                        }
                    }
                }
        } header: {
            Text("Email Address")
        } footer: {
            if !tempEmail.isEmpty && validation.isValidFormat {
                Label("Valid email format", systemImage: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.caption)
            }
        }
    }

    private var validationSection: some View {
        Section {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                    .font(.caption)

                Text("Please enter a valid email address")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
    }


}

class EmailEditorViewModel: BaseViewModel {
    @MainActor
    private func saveEmail() async {
        isLoading = true
        errorMessage = nil

        let trimmedEmail = tempEmail.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            // Call your API service directly
            try await APIService.shared.updateAccount(email: trimmedEmail)

            // Refresh context to get updated user data
            await appState.fetchContext()

            dismiss()
        } catch {
            errorMessage = "Failed to update email: \(error.localizedDescription)"
            showError = true
        }

        isLoading = false
    }
}
