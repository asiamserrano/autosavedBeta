//
//  GameFile.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/23/26.
//

import Foundation
import Core
import SwiftData
import Combine


public protocol GameInterface: UUID.Providing {
    var title: String { get }
    var release: Date { get }
}

@Model
public class Game: ObservableObject, GameInterface {
    
    public private(set) var uuid: UUID
    public var title: String
    public var release: Date
    
    
//    @Relationship(inverse: \Property.games)
//    public var properties: [Property] = [] // Initialize array to prevent potential bugs

    
    private init(uuid: UUID, title: String, release: Date) {
        self.uuid = uuid
        self.title = title
        self.release = release
    }

    private convenience init() {
        self.init(uuid: .defaultValue, title: .defaultValue, release: .defaultValue)
    }

    public protocol Interface: UUID.Providing {
        var title: String { get }
        var release: Date { get }
    }
    
    public struct Snapshot: Equatable, GameInterface {
        
        public static var random: Self {
            .init(uuid: .defaultValue, title: .random, release: .random)
        }
        
        public let uuid: UUID
        public let title: String
        public let release: Date
        
        public init(uuid: UUID, title: String, release: Date) {
            self.uuid = uuid
            self.title = title.trimmed
            self.release = release
        }
        
        @discardableResult
        public func develop(_ game: Game? = nil) -> Game {
            Builder(self.uuid, game)
                .withTitle(self.title)
                .withRelease(self.release)
                .build()
        }
        
    }

    public enum Equality {
        public enum Enum: Enumerable {
            case uuid, storeID, variables
        }
    }
    
    public class Builder {
                
        public let uuid: UUID
        public private(set) var title: String
        public private(set) var release: Date
        
        private var game: Game?
        
        private init(uuid: UUID, title: String, release: Date, _ game: Game?) {
            self.uuid = uuid
            self.title = title.trimmed
            self.release = release
            self.game = game
        }
        
        public convenience init(_ uuid: UUID, _ game: Game? = nil) {
            if let game = game {
                self.init(uuid: game.uuid, title: game.title, release: game.release, game)
            } else {
                self.init(uuid: uuid, title: .defaultValue, release: .defaultValue, nil)
            }
        }
        
        public func withTitle(_ title: String) -> Self {
            self.title = title.trimmed
            return self
        }
        
        public func withRelease(_ release: Date) -> Self {
            self.release = release
            return self
        }
        
        public func build() -> Game {
            let game = self.game ?? Game()
            game.uuid = self.uuid
            game.title = self.title
            game.release = self.release
            return game
        }
        
    }
    
}

extension Game {
    
    public static var random: Game {
        Snapshot.random.develop()
    }
    
    public var snapshot: Snapshot {
        .init(uuid: self.uuid, title: self.title, release: self.release)
    }
    
}

extension GameInterface {
    
    public typealias Instance = GameInterface
    public typealias Equality = Game.Equality.Enum
    
    public static func ==<T: Instance>(lhs: Self, rhs: T) -> Bool {
        lhs.title.trimmed == rhs.title.trimmed &&
        lhs.release.dashes == rhs.release.dashes
    }
    
    public var storeID: String {
        "game|\(self.title.canonicalized)|\(self.release.dashless)"
    }
    
    public var variables: [String] {
        [self.title.trimmed, self.release.dashes]
    }
    
    public func equals<T: Instance>(_ other: T, by equality: Equality) -> Bool {
        switch equality {
        case .uuid:
            return self.uuid == other.uuid
        case .storeID:
            return self.storeID == other.storeID
        case .variables:
            return self == other
        }
    }
    
}

extension Game.Interface {
    
    public typealias Instance = Game.Interface
    public typealias Equality = Game.Equality.Enum
    
    public static func ==<T: Instance>(lhs: Self, rhs: T) -> Bool {
        lhs.title.trimmed == rhs.title.trimmed &&
        lhs.release.dashes == rhs.release.dashes
    }
    
    public var storeID: String {
        "game|\(self.title.canonicalized)|\(self.release.dashless)"
    }
    
    public var variables: [String] {
        [self.title.trimmed, self.release.dashes]
    }
    
    public func equals<T: Instance>(_ other: T, by equality: Equality) -> Bool {
        switch equality {
        case .uuid:
            return self.uuid == other.uuid
        case .storeID:
            return self.storeID == other.storeID
        case .variables:
            return self == other
        }
    }
    
}


