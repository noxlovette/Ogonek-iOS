//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

final class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(for: .milliseconds(.random(in: 100 ... 500)))
        switch url.relativePath {
        case "/lesson":
            return testLessonsData
        case "/task":
            return testTasksData
        case "/deck":
            return testDeckData
        default:
            fatalError("Unsupported URL: \(url.relativePath)")
        }
    }
}
