//
//  APIService+Download.swift
//  Ogonek
//
//  Extension for handling file downloads
//

import Foundation

extension APIService {
    /// Get presigned download URLs for multiple files
    func getPresignedDownloadURLs(for taskID: String) async throws -> [URL] {
        let response = try await client.getPresignedDownloadURLs(fileID: taskID)
        let urls: [URL] = try response.urls.map {
            presignedFile in guard let url = URL(string: presignedFile.url) else {
                throw APIError.invalidURL
            }

            return url
        }

        return urls
    }
}
