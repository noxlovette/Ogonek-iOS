    //
    //  ErrorView.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 14.07.2025.
    //

import SwiftUI

struct ErrorView: View {
    let error: Error
    let onRetry: (() -> Void)?

    init(error: Error, onRetry: (() -> Void)? = nil) {
        self.error = error
        self.onRetry = onRetry
    }

    var body: some View {
        VStack(spacing: 20) {
                // Error icon
            Image(systemName: errorIcon)
                .font(.system(size: 48, weight: .medium))
                .foregroundColor(errorColor)

                // Error message
            VStack(spacing: 8) {
                Text(errorTitle)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)

                Text(errorMessage)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

                // Action buttons
            if shouldShowRetryButton {
                Button(action: {
                    onRetry?()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Try Again")
                    }
                    .font(.body.weight(.medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8)
        )
        .padding(.horizontal, 20)
    }

        // MARK: - Private Properties

    private var errorIcon: String {
        switch error {
            case is CoreError:
                return coreErrorIcon
            case is LessonError:
                return "book.closed"
            case is AssignmentError:
                return "doc.text"
            case is ProfileError:
                return "person.crop.circle.badge.exclamationmark"
            case is DeckError:
                return "rectangle.stack"
            default:
                return "exclamationmark.triangle"
        }
    }

    private var coreErrorIcon: String {
        guard let coreError = error as? CoreError else {
            return "exclamationmark.triangle"
        }

        switch coreError {
            case .networkUnavailable:
                return "wifi.slash"
            case .serverError:
                return "server.rack"
            case .decodingFailed:
                return "exclamationmark.triangle"
            case .unauthorized:
                return "lock.slash"
            case .unexpectedError:
                return "exclamationmark.triangle"
        }
    }

    private var errorColor: Color {
        switch error {
            case let coreError as CoreError:
                switch coreError {
                    case .networkUnavailable:
                        return .orange
                    case .unauthorized:
                        return .red
                    default:
                        return .red
                }
            case is ProfileError:
                return .purple
            default:
                return .red
        }
    }

    private var errorTitle: String {
        switch error {
            case let coreError as CoreError:
                return coreErrorTitle(coreError)
            case let lessonError as LessonError:
                return lessonErrorTitle(lessonError)
            case let assignmentError as AssignmentError:
                return assignmentErrorTitle(assignmentError)
            case let profileError as ProfileError:
                return profileErrorTitle(profileError)
            case let deckError as DeckError:
                return deckErrorTitle(deckError)
            default:
                return "Something went wrong"
        }
    }

    private var errorMessage: String {
            // Check if the error conforms to AppError protocol
        if let appError = error as? AppError {
            return appError.userFacingMessage
        }

            // Fallback to localized description or custom messages
        switch error {
            case let coreError as CoreError:
                return coreErrorMessage(coreError)
            case let lessonError as LessonError:
                return lessonErrorMessage(lessonError)
            case let assignmentError as AssignmentError:
                return assignmentErrorMessage(assignmentError)
            case let profileError as ProfileError:
                return profileErrorMessage(profileError)
            case let deckError as DeckError:
                return deckErrorMessage(deckError)
            default:
                return error.localizedDescription
        }
    }

    private var shouldShowRetryButton: Bool {
            // Check if the error has retry capability
        if let appError = error as? AppError {
            return appError.shouldRetry && onRetry != nil
        }

            // Default retry logic for core errors
        if let coreError = error as? CoreError {
            switch coreError {
                case .networkUnavailable, .serverError:
                    return onRetry != nil
                case .unauthorized:
                    return false
                default:
                    return onRetry != nil
            }
        }

        return onRetry != nil
    }

        // MARK: - Error Title Helpers

    private func coreErrorTitle(_ error: CoreError) -> String {
        switch error {
            case .networkUnavailable:
                return "No Internet Connection"
            case .serverError(let code):
                return "Server Error (\(code))"
            case .decodingFailed:
                return "Data Error"
            case .unauthorized:
                return "Authentication Required"
            case .unexpectedError:
                return "Unexpected Error"
        }
    }

    private func lessonErrorTitle(_ error: LessonError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Invalid Lesson Data"
            case .lessonNotFound:
                return "Lesson Not Found"
            case .invalidLessonType:
                return "Invalid Lesson Type"
            case .core(let coreError):
                return coreErrorTitle(coreError)
        }
    }

    private func assignmentErrorTitle(_ error: AssignmentError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Invalid Assignment Data"
            case .taskNotFound:
                return "Task Not Found"
            case .core(let coreError):
                return coreErrorTitle(coreError)
        }
    }

    private func profileErrorTitle(_ error: ProfileError) -> String {
        switch error {
            case .invalidEmail:
                return "Invalid Email"
            case .passwordTooWeak:
                return "Weak Password"
            case .profileNotFound:
                return "Profile Not Found"
            case .core(let coreError):
                return coreErrorTitle(coreError)
        }
    }

    private func deckErrorTitle(_ error: DeckError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Invalid Deck Data"
            case .deckNotFound:
                return "Deck Not Found"
            case .core(let coreError):
                return coreErrorTitle(coreError)
        }
    }

        // MARK: - Error Message Helpers

    private func coreErrorMessage(_ error: CoreError) -> String {
        switch error {
            case .networkUnavailable:
                return "Please check your internet connection and try again."
            case .serverError(let code):
                return "The server is experiencing issues. Please try again later."
            case .decodingFailed:
                return "We couldn't process the data received from the server."
            case .unauthorized:
                return "Please log in again to continue."
            case .unexpectedError(let underlyingError):
                return "An unexpected error occurred: \(underlyingError.localizedDescription)"
        }
    }

    private func lessonErrorMessage(_ error: LessonError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Some required lesson information is missing."
            case .lessonNotFound:
                return "The lesson you're looking for doesn't exist."
            case .invalidLessonType:
                return "This lesson type is not supported."
            case .core(let coreError):
                return coreErrorMessage(coreError)
        }
    }

    private func assignmentErrorMessage(_ error: AssignmentError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Some required assignment information is missing."
            case .taskNotFound:
                return "The task you're looking for doesn't exist."
            case .core(let coreError):
                return coreErrorMessage(coreError)
        }
    }

    private func profileErrorMessage(_ error: ProfileError) -> String {
        switch error {
            case .invalidEmail:
                return "Please enter a valid email address."
            case .passwordTooWeak:
                return "Password must be at least 8 characters long."
            case .profileNotFound:
                return "Profile not found. Please try logging in again."
            case .core(let coreError):
                return coreErrorMessage(coreError)
        }
    }

    private func deckErrorMessage(_ error: DeckError) -> String {
        switch error {
            case .missingRequiredFields:
                return "Some required deck information is missing."
            case .deckNotFound:
                return "The deck you're looking for doesn't exist."
            case .core(let coreError):
                return coreErrorMessage(coreError)
        }
    }
}

    // MARK: - Convenience Extensions

extension ErrorView {
        /// Creates an ErrorView with a simple retry action
    static func withRetry(error: Error, onRetry: @escaping () -> Void) -> ErrorView {
        ErrorView(error: error, onRetry: onRetry)
    }

        /// Creates an ErrorView without retry capability
    static func withoutRetry(error: Error) -> ErrorView {
        ErrorView(error: error, onRetry: nil)
    }
}

    // MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        ErrorView(error: CoreError.networkUnavailable) {
            print("Retry tapped")
        }

        ErrorView(error: LessonError.lessonNotFound)

        ErrorView(error: ProfileError.invalidEmail)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
