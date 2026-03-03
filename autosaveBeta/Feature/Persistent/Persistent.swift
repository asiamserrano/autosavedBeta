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
    
    public protocol Interface: Compoundable.Interface {
        typealias Implementation = ModelKit.Model.Interface
        typealias Instance = any Implementation
        typealias Enum = Model.Enum
        typealias Builder = Model.Builder
        typealias Array = [Self]
        var instance: Instance { get }
        var builder: Builder { get }
    }

    public enum Model: Interface {

        public enum Enum: Enumerable.Interface {
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
        
        public init<T: Implementation>(_ t: T) {
            if let t = t as? Game {
                self = .game(t)
            } else if let t = t as? Property {
                self = .property(t)
            } else if let t = t as? Platform {
                self = .platform(t)
            } else {
                fatalError("Failed to create Persistent.Model. Unsupported type: \(T.Type.self)")
            }
        }

    }

}

extension Persistent.Interface {
    
    public var type: Enum {
        self.instance.modelType
    }
    
    public var compound: Compound {
        .init(first: self.type, last: self.instance.compound_key)
    }
    
}

extension Persistent.Model {
    
    public var instance: Instance {
        switch self {
        case .game(let game): return game
        case .property(let property): return property
        case .platform(let platform): return platform
        }
    }
    
    public var builder: Builder {
        switch self {
        case .game(let game): return .game(game.builder)
        case .property(let property): return .property(property.builder)
        case .platform(let platform): return .platform(platform.builder)
        }
    }
    
//    public enum Instances {
//        case games, properties, platforms
//    }
    
//    private var myInstance: Instances {
//        switch self {
//        case .game: return .games
//        case .property: return .properties
//        case .platform: return .platforms
//        }
//    }
    
//    public func deleteFilter<M: Implementation, E: Implementation>(_ model: M, _ desired: Enum) -> [E] {
//        
////        // MARK: Original Implementation for method
////        // Example (i == .properties, m = Platform)
////        
////        // this gets an array of Property
////        let eArray: [E] = self.instances(e) as? [E] ?? .defaultValue
////        // cast to an array of Persistent.Model
////        let selfArray: [Self] = eArray.map(\.persistent)
////        
////        // function that determines if the platforms for the property is either empty or only contains the platform instance
////        func isEmptyOrContainsOnly(_ s: Self) -> Bool {
////            let a: [M] = s.instances(m.modelType)
////            return a.count == 0 || a == [m]
////        }
////        // return the array of self filtering the options that should be removed
////        return selfArray.filter(isEmptyOrContainsOnly) as? [E] ?? .defaultValue
//        
////        return self.instances(e).map(\.persistent).filter {
////            let a: [M] = $0.instances(m.modelType)
////            return a.isEmptyOrContainsOnly(m)
////        } as? [E] ?? .defaultValue
//        
//        self.instances(desired).filter {
//            let array: [M] = $0.persistent.instances(model.modelType)
//            return array.count == 0 || array == [model]
//        }
//        
//    }
//    
//    public func instances<I: Implementation>(_ i: Enum) -> [I] {
//        self.instances(i) as? [I] ?? .defaultValue
//    }
//    
//    public func instances(_ i: Enum) -> [Instance] {
//        // get my array of instances for i (ex: platform will return [Property] for i == .properties)
//        switch self {
//        case .game(let game):
//            switch i {
//            case .game: return .defaultValue
//            case .property: return game.properties
//            case .platform: return game.platforms
//            }
//        case .property(let property):
//            switch i {
//            case .game: return property.games
//            case .property: return .defaultValue
//            case .platform: return property.platforms
//            }
//        case .platform(let platform):
//            switch i {
//            case .game: return platform.games
//            case .property: return platform.properties
//            case .platform: return .defaultValue
//            }
//        }
//    }
    
//    private func instances2(_ i: Instances) -> [Instance] {
//        switch self {
//        case .game(let game):
//            switch i {
//            case .games: return .defaultValue
//            case .properties: return game.properties.filter { $0.games.isEmptyOrContainsOnly(game) }
//            case .platforms: return game.platforms
//            }
//        case .property(let property):
//            switch i {
//            case .games: return property.games
//            case .properties: return .defaultValue
//            case .platforms: return property.platforms
//            }
//        case .platform(let platform):
//            switch i {
//            case .games: return platform.games
//            case .properties: return platform.properties
//            case .platforms: return .defaultValue
//            }
//        }
//    }
    
}

extension Persistent.Model.Enum {
    
    public var models: ModelContainer.Models {
        switch self {
        case .game: return .init(Game.self)
        case .property: return .init(Property.self)
        case .platform: return .init(Platform.self)
        }
    }
    
    public var navigationConstant: Constants {
        switch self {
        case .game: return .games
        case .property: return .properties
        case .platform: return .platforms
        }
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

}
