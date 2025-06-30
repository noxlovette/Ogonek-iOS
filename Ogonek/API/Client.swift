//
//  Client.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

struct APIClient {
    private let downloader: any HTTPDataDownloader
    private let decoder: JSONDecoder

    // well we might also pass url.shared straight away but APIClient is meaningless without type clients
    init(downloader: any HTTPDataDownloader) {
        self.downloader = downloader
        decoder = JSONDecoderFactory.defaultDecoder()
    }

    func fetch<T: Decodable>(from: URL) async throws -> T {
        let data = try await downloader.httpData(from: from)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
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

struct LessonClient {
    private let apiClient: APIClient

    private let feedURL = URL(string: "http://localhost:3000/lesson")!

    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        apiClient = APIClient(downloader: downloader)
    }

    func getLessons() async throws -> [Lesson] {
        let response: LessonResponse = try await apiClient.fetch(from: feedURL)
        return response.data
    }
}

struct TaskClient {
    private let apiClient: APIClient

    private let feedURL = URL(string: "http://localhost:3000/task")!

    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        apiClient = APIClient(downloader: downloader)
    }

    func getTasks() async throws -> [Assignment] {
        let response: TaskResponse = try await apiClient.fetch(from: feedURL)
        return response.data
    }
}

struct DeckClient {
    private let apiClient: APIClient

    private let feedURL = URL(string: "http://localhost:3000/deck")!

    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        apiClient = APIClient(downloader: downloader)
    }

    func getDecks() async throws -> [Deck] {
        let response: [Deck] = try await apiClient.fetch(from: feedURL)
        return response
    }
}
