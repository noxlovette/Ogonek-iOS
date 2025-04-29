//
//  Lesson.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

struct Lesson: Identifiable, Decodable {
    let id: String
    let title: String
    let topic: String
    let markdown: String
    let assignee: String
    let createdBy: String
    let createdAt: Date
    let updatedAt: Date
    let assigneeName: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case topic
        case markdown
        case assignee
        case createdBy
        case createdAt
        case updatedAt
        case assigneeName
    }
}
