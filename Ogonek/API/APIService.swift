import Foundation
import Observation

@Observable
class APIService {
    private let downloader: any HTTPDataDownloader
    private let decoder: JSONDecoder
    private let baseURL: URL

    init(baseURL: String = "http://localhost:3000", downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
        self.decoder = JSONDecoderFactory.defaultDecoder()
        self.baseURL = URL(string: baseURL)!
    }

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint)
        let data = try await downloader.httpData(from: url)
        return try decoder.decode(type, from: data)
    }
}
