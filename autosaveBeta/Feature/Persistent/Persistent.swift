//
//  Persistent.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/14/26.
//

import Foundation
import SwiftData
import Core

public enum Persistent {

    public enum Model {

        public enum Enum: Enumerable {
            case game, property, platform
        }

        public enum Builder: BuilderKit.Implementation.Interface {
            case game(Game.Builder)
            case property(Property.Builder)
            case platform(Platform.Builder)
        }

        case game(Game)
        case property(Property)
        case platform(Platform)

    }

}

extension Persistent.Model.Builder {
    
    public typealias Enum = Persistent.Model.Enum
    
    public static var random: Self {
        .random(.random)
    }

    public static func random(_ type: Enum) -> Self {
        switch type {
        case .game: return .random
        case .property: return .random
        case .platform: return .random
        }
    }
    
    public var type: Enum {
        switch self {
        case .game: .game
        case .property: .property
        case .platform: .platform
        }
    }

    public var instance: Instance {
        switch self {
        case .game(let g): return g
        case .property(let p): return p
        case .platform(let p): return p
        }
    }

    public var compound: Compound {
        .init(storage: [
            0: self.type.id,
            1: self.instance.id
        ])
    }

}
