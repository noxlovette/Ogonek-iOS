//
//  TabBar.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
            LessonListView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Lessons")
                }.tag(1)
            TaskListView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Tasks")
                }.tag(2)
            DeckListView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Decks")
                }.tag(3)
        }
    } 
}

#Preview {
    TabBar()
}
