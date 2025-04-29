//
//  LessonJSON.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

struct LessonJSON: Decodable {
        let data: [Lesson]
        let total: Int
        let page: Int
        let perPage: Int

        
    private enum CodingKeys: String, CodingKey {
        case data
        case total
        case page
        case per_page
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.data = try container.decode([Lesson].self, forKey: .data)
            self.total = try container.decode(Int.self, forKey: .total)
            self.page = try container.decode(Int.self, forKey: .page)
            self.perPage = try container.decode(Int.self, forKey: .per_page)
        }
}

