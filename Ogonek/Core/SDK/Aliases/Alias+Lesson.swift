//
//  Alias+Lesson.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

typealias Lesson = Components.Schemas.LessonFull
typealias LessonSmall = Components.Schemas.LessonSmall

extension Lesson: Identifiable {}
extension LessonSmall: Identifiable {}
