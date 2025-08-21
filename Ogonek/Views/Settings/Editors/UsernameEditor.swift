import SwiftUI
struct UsernameEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @State private var tempUsername: String = ""
    @FocusState private var isUsernameFocused: Bool

    private var currentUsername: String {
        appState.context.user.username
    }

    private var hasChanges: Bool {
        tempUsername.trimmingCharacters(in: .whitespacesAndNewlines) != currentUsername && !tempUsername.isEmpty
    }

    private var canSave: Bool {
        hasChanges && !isLoading
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Username", text: $tempUsername)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($isUsernameFocused)
                        .submitLabel(.done)
                        .onSubmit {
                            if canSave {
                                Task { await saveUsername() }
                            }
                        }
                } header: {
                    Text("Username")
                }
            }
            .navigationTitle("Edit Username")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .disabled(isLoading)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task { await saveUsername() }
                    }
                    .disabled(!canSave)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                tempUsername = currentUsername
                isUsernameFocused = true
            }
            .overlay {
                if isLoading {
                    LoadingOverlay()
                }
            }
            .alert("Error", isPresented: $showError) {
                Button("OK") { errorMessage = nil }
            } message: {
                if let errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }

    @MainActor
    private func saveUsername() async {
        isLoading = true
        errorMessage = nil

        let trimmedUsername = tempUsername.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            // Call your API service directly
            try await APIService.shared.updateAccount(username: trimmedUsername)

            // Refresh context to get updated user data
            await appState.fetchContext()

            dismiss()
        } catch {
            errorMessage = "Failed to update username: \(error.localizedDescription)"
            showError = true
        }

        isLoading = false
    }
}


class UserNameEditorViewModel: BaseViewModel {
    
}
