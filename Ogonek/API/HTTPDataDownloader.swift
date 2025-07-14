//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

let validStatus = 200 ... 299

protocol HTTPDataDownloader: Sendable {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode)
        else {
            throw LessonError.core(.networkUnavailable) // change to core
        }
        return data
    }
}
