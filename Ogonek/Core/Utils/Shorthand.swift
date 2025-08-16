//
//  Shorthand.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

func notImplemented() -> Never {
    fatalError("Not Implemented")
}

extension String? {
    var isNil: Bool {
        self == nil
    }
}

let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
