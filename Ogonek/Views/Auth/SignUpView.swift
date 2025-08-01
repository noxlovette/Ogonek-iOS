    //
    //  SignUpView.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 01.08.2025.
    //

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sign up functionality coming soon...")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding()
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SignUpView()
}
