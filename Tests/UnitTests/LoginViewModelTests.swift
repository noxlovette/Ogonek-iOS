//
//  LoginViewModelTests.swift
//  OgonekTests
//

@testable import Ogonek
import XCTest

final class LoginViewModelTests: XCTestCase {
    @MainActor
    override func setUp() {
        super.setUp()
        // Clean state before each test
        TokenManager.shared.logout()
    }

    // MARK: - Basic Form Validation

    @MainActor
    func testInitialState() {
        let viewModel = LoginViewModel()

        XCTAssertEqual(viewModel.username, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertFalse(viewModel.canSignIn)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    @MainActor
    func testCanSignInWithValidCredentials() {
        let viewModel = LoginViewModel()

        viewModel.username = "testuser"
        viewModel.password = "testpassword"

        XCTAssertTrue(viewModel.canSignIn)
    }

    @MainActor
    func testCannotSignInWithEmptyUsername() {
        let viewModel = LoginViewModel()

        viewModel.username = ""
        viewModel.password = "testpassword"

        XCTAssertFalse(viewModel.canSignIn)
    }

    @MainActor
    func testCannotSignInWithEmptyPassword() {
        let viewModel = LoginViewModel()

        viewModel.username = "testuser"
        viewModel.password = ""

        XCTAssertFalse(viewModel.canSignIn)
    }

    @MainActor
    func testCannotSignInWhileLoading() {
        let viewModel = LoginViewModel()

        viewModel.username = "testuser"
        viewModel.password = "testpassword"
        viewModel.isLoading = true

        XCTAssertFalse(viewModel.canSignIn)
    }

    // MARK: - Error Handling

    @MainActor
    func testErrorMessageClearsWhenSet() {
        let viewModel = LoginViewModel()

        viewModel.errorMessage = "Test error"
        XCTAssertNotNil(viewModel.errorMessage)

        viewModel.clearError()
        XCTAssertNil(viewModel.errorMessage)
    }

    @MainActor
    func testClearFormResetsAllFields() {
        let viewModel = LoginViewModel()

        viewModel.username = "testuser"
        viewModel.password = "testpassword"
        viewModel.errorMessage = "Test error"

        viewModel.clearForm()

        XCTAssertEqual(viewModel.username, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertNil(viewModel.errorMessage)
    }
}
