//
//  File.swift
//  Ogonek
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

final class JSONDecoderFactory {
    static func defaultDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(customDateFormatter())
        return decoder
    }

    private static func customDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"  // Allow milliseconds
        formatter.timeZone = TimeZone(secondsFromGMT: 0)  // UTC time zone (Z)
        return formatter
    }
}
