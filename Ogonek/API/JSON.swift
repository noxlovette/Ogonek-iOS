//
//  LessonJSON.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let data: [T]
    let total: Int
    let page: Int
    let perPage: Int

    private enum CodingKeys: String, CodingKey {
        case data
        case total
        case page
        case perPage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([T].self, forKey: .data)
        self.total = try container.decode(Int.self, forKey: .total)
        self.page = try container.decode(Int.self, forKey: .page)
        self.perPage = try container.decode(Int.self, forKey: .perPage)
    }
}

typealias LessonResponse = PaginatedResponse<Lesson>
// typealias TaskResponse = PaginatedResponse<Task>
// typealias UserResponse = PaginatedResponse<User>

// TODO: include the single lesson case
