//
//  Clients.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

struct LessonClient {
    var lessons: [Lesson] {
        get async throws {
            print("accessing downloader data")
            let data = try await downloader.httpData(
                from: feedURL,
                type: dataType.lessons
            )
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
                    case let .dataCorrupted(context):
                        print("Data corrupted: \(context)")
                    case let .keyNotFound(key, context):
                        print("Key '\(key)' not found: \(context)")
                    case let .typeMismatch(type, context):
                        print("Type mismatch for type \(type): \(context)")
                    case let .valueNotFound(type, context):
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

struct TaskClient {
    var tasks: [Assignment] {
        get async throws {
            print("accessing downloader data")
            let data = try await downloader.httpData(from: feedURL, type: .tasks)
            print("accessed downloader data, fetching all lessons")

            do {
                let allTasks = try decoder.decode(
                    TaskResponse.self,
                    from: data
                )
                print("fetched all lessons")
                logger.info("fetched lesson data")
                print("returning all lessons")
                return allTasks.data
            } catch {
                print("DECODING ERROR: \(error)")
                if let decodingError = error as? DecodingError {
                    print("Detailed decoding error:")
                    switch decodingError {
                    case let .dataCorrupted(context):
                        print("Data corrupted: \(context)")
                    case let .keyNotFound(key, context):
                        print("Key '\(key)' not found: \(context)")
                    case let .typeMismatch(type, context):
                        print("Type mismatch for type \(type): \(context)")
                    case let .valueNotFound(type, context):
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
