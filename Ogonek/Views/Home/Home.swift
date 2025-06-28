//
//  Home.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Ogonek").font(.largeTitle).fontWeight(.bold).padding()

            Text("Let's get the party started!").font(.headline).padding()
        }
    }
}

#Preview {
    HomeView()
}
