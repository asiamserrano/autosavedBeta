//
//  Game+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public class GameBuilder: IdentifiableProtocol {
    
    public private (set) var uuid: UUID = .init()
    public private (set) var builders: [PropertyBuilder] = .init()
    
    public var title: String = .empty
    public var release: Date = .today
    public var owned: Bool = true
    public var image: Data? = nil
        
    public init() { }
    
    public convenience init(_ game: Game) {
        self.init()
        self.uuid = game.uuid
        self.withTitle(game.title)
        self.withRelease(game.release)
        self.withStatus(game.status)
        self.withImage(game.image)
        self.setProperties(game.builders)
    }
    
    public var dictionary: PropertyDictionary { .init(self.builders) }
    
    public func equals(_ other: GameBuilder) -> Bool {
        self.title.trimmed == other.title.trimmed
        && self.release.dashless == other.release.dashless
        && self.image == other.image
        && self.dictionary == other.dictionary
    }
 
}

extension GameBuilder {
    
    @discardableResult
    public func withTitle(_ str: String?) -> Self {
        self.title = str?.trimmed ?? .empty
        return self
    }
    
    @discardableResult
    public func withRelease(_ dt: Date?) -> Self {
        self.release = .init(dt ?? .today)
        return self
    }
    
    @discardableResult
    public func withStatus(_ b: Bool) -> Self {
        self.owned = b
        return self
    }
    
    @discardableResult
    public func withImage(_ i: Data?) -> Self {
        self.image = i
        return self
    }

    @discardableResult
    public func setProperties(_ builders: [PropertyBuilder]) -> Self {
        self.builders = builders
        return self
    }
    
    @discardableResult
    public func setProperties(_ dict: PropertyDictionary) -> Self {
        self.setProperties(dict.allObjects)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.title.canonicalized)
        hasher.combine(self.release)
    }
    
//    public func properties(_ con: Context) -> NSSet {
//        .buildForProperties(self.builders, con)
//    }
    
    @discardableResult
    public func build(_ con: Context) -> Game {
        .init(context: con).update(con, self)
    }
    
}
