//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

// Add this to your LessonClient to see exactly what's failing

struct LessonClient {
    var lessons: [Lesson] {
        get async throws {
            print("accessing downloader data")
            let data = try await downloader.httpData(from: feedURL)
            print("accessed downloader data, fetching all lessons")

            do {
                let allLessons = try decoder.decode(
                    LessonResponse.self,
                    from: data
                )
                print("fetched all lessons")
                logger.info("fetched lesson data")
                print("returning all lessons")
                return allLessons.data
            } catch {
                print("DECODING ERROR: \(error)")
                if let decodingError = error as? DecodingError {
                    print("Detailed decoding error:")
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key)' not found: \(context)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type \(type): \(context)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type \(type): \(context)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                throw error
            }
        }
    }

    private var decoder = JSONDecoderFactory.defaultDecoder()
    private let feedURL = URL(string: "http://localhost:3000/lesson")!
    private let downloader: any HTTPDataDownloader

    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
