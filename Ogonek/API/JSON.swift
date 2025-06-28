//
//  JSON.swift
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
        data = try container.decode([T].self, forKey: .data)
        total = try container.decode(Int.self, forKey: .total)
        page = try container.decode(Int.self, forKey: .page)
        perPage = try container.decode(Int.self, forKey: .perPage)
    }
}

typealias LessonResponse = PaginatedResponse<Lesson>
typealias TaskResponse = PaginatedResponse<Assignment>
// typealias UserResponse = PaginatedResponse<User>

// TODO: include the single lesson case
