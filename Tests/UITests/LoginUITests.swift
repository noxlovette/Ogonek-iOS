//
//  LoginUITests.swift
//  OgonekUITests
//

import XCTest

final class LoginUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TESTING_MODE": "1"]
        app.launch()
    }

    func testLoginScreenElementsExist() {
        // Test that basic login elements are present
        XCTAssertTrue(app.textFields["Username"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.buttons["Sign In"].exists)
    }

    func testUsernameFieldInput() {
        let usernameField = app.textFields["Username"]

        usernameField.tap()
        usernameField.typeText("testuser")

        // Verify the field contains text (value property works for text fields)
        XCTAssertEqual(usernameField.value as? String, "testuser")
    }

    func testPasswordFieldInput() {
        let passwordField = app.secureTextFields["Password"]

        passwordField.tap()
        passwordField.typeText("testpassword")

        // Password fields don't expose their value, so just verify existence
        XCTAssertTrue(passwordField.exists)
    }

    func testSignInButtonEnabledWithValidInput() {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign In"]

        // Initially disabled
        XCTAssertFalse(signInButton.isEnabled)

        // Fill in credentials
        usernameField.tap()
        usernameField.typeText("testuser")

        passwordField.tap()
        passwordField.typeText("testpassword")

        // Wait for button to become enabled
        let expectation = expectation(for: NSPredicate(format: "isEnabled == true"),
                                      evaluatedWith: signInButton,
                                      handler: nil)
        wait(for: [expectation], timeout: 2.0)

        XCTAssertTrue(signInButton.isEnabled)
    }

    func testSignInButtonDisabledWithEmptyUsername() {
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign In"]

        // Fill only password
        passwordField.tap()
        passwordField.typeText("testpassword")

        // Wait a moment for UI to update
        sleep(1)

        XCTAssertFalse(signInButton.isEnabled)
    }
}
