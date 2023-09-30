//
//  Game+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public class GameBuilder: IdentifiableProtocol {
    
    public var title: String = .empty
    public var release: Date = .today
    public var owned: Bool = true
    public var image: Data? = nil
    public var properties: [PropertyBuilder] = .init()
    
    public init() { }
    
    public convenience init(_ game: Game) {
        self.init()
        self.withTitle(game.title_string)
        self.withRelease(game.release_date)
        self.withStatus(game.owned_boolean)
        self.withImage(game.image_data)
        self.setProperties(game.properties.map{$0.builder})
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
        self.release = dt ?? .today
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
        self.properties = builders
        return self
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.title.canonicalized)
        hasher.combine(self.release)
    }
    
    @discardableResult
    public func build(_ con: Context) -> Game {
        .init(context: con).set(self).set(self.properties.map(con.fetchProperty))
    }
    
}
