//
//  OgonekTests.swift
//  Ogonek SwiftTests
//
//  Created by Nox Lovette on 17.04.2025.
//

import Foundation
@testable import Ogonek
import Testing

struct OgonekTests {
    @Test func lessonJSONDecoderLessonsMultiple() throws {
        let decoder = JSONDecoderFactory.defaultDecoder()
        let decoded = try decoder.decode(LessonJSON.self, from: testLessonsData)
        #expect(decoded.data.count == 3)
        #expect(decoded.data[0].id == "Bc3JW7pm1Zh450ty95fAI")
    }

    @Test func clientDoesFetchLessonData() async throws {
        let downloader = TestDownloader()
        let client = LessonClient(downloader: downloader)
        let lessons = try await client.lessons
        #expect(lessons.count == 3)
    }
}
