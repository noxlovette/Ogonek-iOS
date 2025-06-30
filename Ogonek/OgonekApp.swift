//
//  OgonekApp.swift
//  Ogonek Swift
//
//  Created by Nox Lovette on 17.04.2025.
//

import SwiftUI

@main
struct Ogonek: App {
    var body: some Scene {
        @State var lessonProvider = LessonProvider()
        WindowGroup {
            HomeView()
        }
        .environment(lessonProvider)
    }
}
