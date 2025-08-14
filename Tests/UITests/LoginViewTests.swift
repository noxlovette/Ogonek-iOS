    //
    //  LoginViewTests.swift
    //  OgonekUITests
    //
    //  Created by Danila Volkov on 14.08.2025.
    //

import XCTest

final class LoginViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

            // Configure app for testing
        app.launchArguments = ["--testing"]
        app.launchEnvironment = ["TESTING_MODE": "1"]
        app.launch()

            // Navigate to login view if not already there
        navigateToLoginIfNeeded()
    }

    private func navigateToLoginIfNeeded() {
            // If already logged in, logout first to get to login screen
        if app.tabBars.firstMatch.exists {
                // Tap logout in dashboard (you'll need to adapt based on your logout flow)
            let dashboardTab = app.tabBars.buttons["Home"]
            if dashboardTab.exists {
                dashboardTab.tap()
                    // Add logout navigation here based on your UI
            }
        }
    }

        // MARK: - UI Elements Tests

    func testLoginViewElementsExist() throws {
            // Test header elements
        XCTAssertTrue(app.images["flame.fill"].exists, "Flame icon should be visible")
        XCTAssertTrue(app.staticTexts["Welcome to"].exists, "Welcome text should be visible")
        XCTAssertTrue(app.staticTexts["Ogonek"].exists, "App name should be visible")

            // Test form elements
        XCTAssertTrue(app.textFields["Username"].exists, "Username field should be visible")
        XCTAssertTrue(app.secureTextFields["Password"].exists, "Password field should be visible")
        XCTAssertTrue(app.buttons["Sign In"].exists, "Sign In button should be visible")
    }

    func testInitialSignInButtonState() throws {
        let signInButton = app.buttons["Sign In"]
        XCTAssertTrue(signInButton.exists)
        XCTAssertFalse(signInButton.isEnabled, "Sign In button should be disabled initially")
    }

        // MARK: - Form Interaction Tests

    func testUsernameFieldInteraction() throws {
        let usernameField = app.textFields["Username"]

        usernameField.tap()
        usernameField.typeText("testuser")

        XCTAssertEqual(usernameField.value as? String, "testuser")
    }

    func testPasswordFieldInteraction() throws {
        let passwordField = app.secureTextFields["Password"]

        passwordField.tap()
        passwordField.typeText("testpassword")

            // Password fields don't expose their value for security
        XCTAssertTrue(passwordField.exists)
    }

    func testSignInButtonEnabledWithValidInput() throws {
        fillLoginForm(username: "testuser", password: "testpassword")

        let signInButton = app.buttons["Sign In"]

            // Wait for button to become enabled (due to validation)
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "isEnabled == true"),
            object: signInButton
        )

        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(signInButton.isEnabled, "Sign In button should be enabled with valid input")
    }

    func testSignInButtonDisabledWithEmptyUsername() throws {
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("testpassword")

        let signInButton = app.buttons["Sign In"]

            // Give UI time to update
        Thread.sleep(forTimeInterval: 0.5)

        XCTAssertFalse(signInButton.isEnabled, "Sign In button should be disabled with empty username")
    }

    func testSignInButtonDisabledWithEmptyPassword() throws {
        let usernameField = app.textFields["Username"]
        usernameField.tap()
        usernameField.typeText("testuser")

        let signInButton = app.buttons["Sign In"]

            // Give UI time to update
        Thread.sleep(forTimeInterval: 0.5)

        XCTAssertFalse(signInButton.isEnabled, "Sign In button should be disabled with empty password")
    }

        // MARK: - Authentication Flow Tests

    func testSuccessfulLogin() throws {
            // Configure app for successful login mock
        app.terminate()
        app.launchEnvironment["MOCK_LOGIN_SUCCESS"] = "true"
        app.launchArguments = ["--testing"]
        app.launch()
        navigateToLoginIfNeeded()

        fillLoginForm(username: TestData.validUsername, password: TestData.validPassword)

        let signInButton = app.buttons["Sign In"]
        signInButton.tap()

            // Verify we navigate to the main app (dashboard)
        let dashboardTitle = app.navigationBars["Dashboard"]
        XCTAssertTrue(dashboardTitle.waitForExistence(timeout: 5.0), "Should navigate to dashboard after successful login")
    }

    func testFailedLoginShowsAlert() throws {
            // Configure app for failed login mock
        app.terminate()
        app.launchEnvironment["MOCK_LOGIN_FAILURE"] = "true"
        app.launchArguments = ["--testing"]
        app.launch()
        navigateToLoginIfNeeded()

        fillLoginForm(username: "invaliduser", password: "invalidpassword")

        let signInButton = app.buttons["Sign In"]
        signInButton.tap()

            // Verify error alert appears
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 3.0), "Error alert should appear after failed login")

        let alertMessage = alert.staticTexts["Invalid username or password"]
        XCTAssertTrue(alertMessage.exists, "Alert should show invalid credentials message")

            // Dismiss alert
        alert.buttons["OK"].tap()

            // Verify we're still on login screen
        XCTAssertTrue(app.textFields["Username"].exists, "Should remain on login screen after failed login")
    }

    func testLoadingStateDisablesButton() throws {
            // Configure app for slow login response
        app.terminate()
        app.launchEnvironment["MOCK_LOGIN_SLOW"] = "true"
        app.launchArguments = ["--testing"]
        app.launch()
        navigateToLoginIfNeeded()

        fillLoginForm(username: "testuser", password: "testpassword")

        let signInButton = app.buttons["Sign In"]
        signInButton.tap()

            // Verify loading state
        let loadingText = app.staticTexts["Signing In..."]
        XCTAssertTrue(loadingText.waitForExistence(timeout: 2.0), "Loading text should appear")

            // Verify button is disabled during loading
        XCTAssertFalse(signInButton.isEnabled, "Sign In button should be disabled during loading")

            // Verify progress indicator appears
        let progressView = app.activityIndicators.firstMatch
        XCTAssertTrue(progressView.exists, "Progress indicator should be visible during loading")
    }

        // MARK: - Accessibility Tests

    func testAccessibilityLabels() throws {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign In"]

        XCTAssertEqual(usernameField.label, "Username", "Username field should have proper accessibility label")
        XCTAssertEqual(passwordField.label, "Password", "Password field should have proper accessibility label")
        XCTAssertEqual(signInButton.label, "Sign In", "Sign In button should have proper accessibility label")
    }

    func testVoiceOverNavigation() throws {
            // Enable VoiceOver for testing
            // Note: This requires additional setup in your test scheme

        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign In"]

            // Test that elements are accessible in logical order
        XCTAssertTrue(usernameField.isAccessibilityElement)
        XCTAssertTrue(passwordField.isAccessibilityElement)
        XCTAssertTrue(signInButton.isAccessibilityElement)
    }

        // MARK: - Error Handling Tests

    func testNetworkErrorHandling() throws {
            // Configure app for network error
        app.terminate()
        app.launchEnvironment["MOCK_NETWORK_ERROR"] = "true"
        app.launchArguments = ["--testing"]
        app.launch()
        navigateToLoginIfNeeded()

        fillLoginForm(username: "testuser", password: "testpassword")

        let signInButton = app.buttons["Sign In"]
        signInButton.tap()

            // Verify network error alert
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 3.0), "Network error alert should appear")

        let networkErrorMessage = alert.staticTexts["Login failed. Please check your connection and try again."]
        XCTAssertTrue(networkErrorMessage.exists, "Should show network error message")
    }

        // MARK: - Helper Methods

    private func fillLoginForm(username: String, password: String) {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]

        usernameField.tap()
        usernameField.typeText(username)

        passwordField.tap()
        passwordField.typeText(password)
    }
}

    // MARK: - Performance Tests

extension LoginViewUITests {

    func testLoginViewLaunchPerformance() throws {
            // Measure login view presentation time
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            app.terminate()
            app.launch()
        }
    }

    func testLoginFormInteractionPerformance() throws {
            // Measure form interaction responsiveness
        let options = XCTMeasureOptions()
        options.iterationCount = 5

        measure(options: options) {
            fillLoginForm(username: "perftest", password: "perftest")

                // Clear form for next iteration
            let usernameField = app.textFields["Username"]
            usernameField.tap()
            usernameField.clearText()

            let passwordField = app.secureTextFields["Password"]
            passwordField.tap()
            passwordField.clearText()
        }
    }
}

    // MARK: - XCUIElement Extensions for Testing

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear text on element that doesn't have a string value")
            return
        }

            // Triple tap to select all text
        self.tap()
        self.doubleTap()

            // Delete the selected text
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
