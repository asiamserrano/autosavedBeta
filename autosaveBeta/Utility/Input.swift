//
//  Input.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 1/28/26.
//

import Foundation
import Core

public struct Input {
    
    public enum Enum: Enumerable {
        case series, developer, publisher, genre
    }
    
    public struct Builder {
        
        public let type: Enum
        public let rawValue: String

        public init(_ t: Enum, _ s: String) {
            self.type = t
            self.rawValue = s.trimmed
        }

    }
    
}

extension Input.Builder: BuilderKit.Interface {
    
    public static var random: Self {
        .random(.random)
    }
    
    public static func random(_ i: Input.Enum) -> Self {
        .init(i, .random)
    }
    
    public var representation: String {
        "(\(self.type.rawValue)) \(self.rawValue)"
    }
    
    public var compound: Compound {
        .init(storage: [
            0: self.type.id,
            1: self.rawValue.canonicalized
        ])
    }
    
}
