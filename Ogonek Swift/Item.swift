//
//  Item.swift
//  Ogonek Swift
//
//  Created by Nox Lovette on 17.04.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
