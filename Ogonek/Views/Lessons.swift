//
//  Lessons.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation
import SwiftUI


struct Lessons: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @Environment(LessonsProvider.self) var provider
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    @State private var error: LessonError?
    @State private var hasError = false

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.lessons) { lesson in
                    LessonRow(lesson: lesson)
                }
                .onDelete(perform: deleteLessons)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchLessons()
            }
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchLessons()
        }
    }
}

extension Lessons {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }

    func deleteLessons(at offsets: IndexSet) {
        provider.deleteLessons(atOffsets: offsets)
    }
    func deleteLessons(for ids: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.lessons.enumerated() {
            if ids.contains(element.id) {
                offsetsToDelete.insert(index)
            }
        }
        deleteLessons(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchLessons() async {
        isLoading = true
        do {
            try await provider.fetchLessons()
            lastUpdated = Date().timeIntervalSince1970
            
        } catch {
            self.error = error as? LessonError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

#Preview {
    Lessons()
        .environment(
            LessonsProvider(client:
                          LessonClient(downloader: TestDownloader()))
        )
}
