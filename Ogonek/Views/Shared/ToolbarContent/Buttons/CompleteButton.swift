/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The refresh button of the app.
 */

import SwiftUI

struct CompleteButton: View {
    var action: () -> Void = {}
    var condition: Bool = false
    var recto: String
    var verso: String

    var body: some View {
        Button(action: action) {
            Label(condition ? recto : verso, systemImage: condition ? "checkmark.circle.fill" : "circle")
        }
    }
}
