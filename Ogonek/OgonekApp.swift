//
//  Ogonek_SwiftApp.swift
//  Ogonek Swift
//
//  Created by Nox Lovette on 17.04.2025.
//

import SwiftUI

@main
struct Ogonek: App {
    
    var body: some Scene {
        @State var lessonsProvider = LessonsProvider()
        WindowGroup {
            LessonListView()
        }
        .environment(lessonsProvider)
    }
}
