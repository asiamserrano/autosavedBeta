//
//  Game+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public class GameBuilder: GameBuilderProtocol {
    
    public private (set) var uuid: UUID = .init()
    public private (set) var add: Date = .today
    
    public var dictionary: PropertyDictionary = .init()
    
    public var title: String = .empty
    public var release: Date = .today
    public var owned: Bool = true
    public var image: Data? = nil
    
    public init() { }
    
    public convenience init(_ game: Game) {
        self.init()
        self.uuid = game.uuid
        self.add = game.add
        self.withTitle(game.title)
        self.withRelease(game.release)
        self.withStatus(game.status)
        self.withImage(game.image)
        self.withDictionary(game.builders)
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
    public func withDictionary(_ builders: [PropertyBuilder]) -> Self {
        self.withDictionary(.init(builders))
    }
    
    @discardableResult
    public func withDictionary(_ dict: PropertyDictionary) -> Self {
        self.dictionary = dict
        return self
    }
    
    @discardableResult
    public func withRandomAddDate() -> Self {
        self.add = .random
        return self
    }
    
}
