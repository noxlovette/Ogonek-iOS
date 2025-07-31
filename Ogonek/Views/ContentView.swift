//
//  ContentView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }.tag(0)
            LessonListView()
                .tabItem {
                    Label("Lessons", systemImage: "book.pages")
                }.tag(1)
            TaskGridView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }.tag(2)
            DeckGridView(decks: Deck.previewSet)
                .tabItem {
                    Label("Learn", systemImage: "graduationcap")
                }.tag(3).badge(5)
        }
    }
}

#Preview {
    ContentView()
}
