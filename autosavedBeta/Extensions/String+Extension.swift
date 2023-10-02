//
//  String+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation

public extension String {
    
    static var empty: Self { .init() }
    
    static var random: Self {
        let uuid: Self = UUID().uuidString
        let strs: [Substring] = uuid.split(separator: "-")
        return strs.randomElement()!.description
    }

    var trimmed: Self {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var canonicalized: Self {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
            .lowercased()
    }
    
    var isEmpty: Bool {
        self.canonicalized.count == 0
    }
    
    func equals(_ other: Self) -> Bool {
        self.canonicalized == other.canonicalized
    }

}
