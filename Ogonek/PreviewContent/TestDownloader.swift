//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by Danila Volkov on 28.04.2025.
//

import Foundation

final class TestDownloader: HTTPDataDownloader {
    func httpData(from _: URL, type: dataType) async throws -> Data {
        try await Task.sleep(for: .milliseconds(.random(in: 100 ... 500)))
        switch type {
        case .lessons:
            return testLessonsData
        case .tasks:
            return testTasksData
        }
    }
}
