//
//  Item.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/9/26.
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
