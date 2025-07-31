//
//  ContentView.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var apiService: APIService
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            LessonListView()
                .tabItem {
                    Label("Lessons", systemImage: "book.pages")
                }
                .tag(1)

            TaskGridView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }
                .tag(2)

            DeckGridView()
                .tabItem {
                    Label("Learn", systemImage: "graduationcap")
                }
                .tag(3)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Sign Out", role: .destructive) {
                        apiService.logout()
                    }
                } label: {
                    Image(systemName: "person.circle")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
