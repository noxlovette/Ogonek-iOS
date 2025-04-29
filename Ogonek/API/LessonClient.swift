//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

struct LessonClient {
    var lessons: [Lesson] {
            get async throws {
                let data = try await downloader.httpData(from: feedURL)
                let allLessons = try decoder.decode(LessonJSON.self, from: data)
                return allLessons.data
            }
        }
    
    private var decoder = JSONDecoderFactory.defaultDecoder()
    
    private let feedURL = URL(string: "http://localhost:3000/lesson")!
    
    private let downloader: any HTTPDataDownloader


        init(downloader: any HTTPDataDownloader = URLSession.shared) {
            self.downloader = downloader
        }
}
