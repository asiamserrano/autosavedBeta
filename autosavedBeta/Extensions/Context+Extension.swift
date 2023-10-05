//
//  Context+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData
import SwiftUI

public typealias Context = NSManagedObjectContext

extension Context {
    
    @discardableResult
    public func store() -> Bool {
        do {
            try self.save()
            return true
        } catch {
            self.rollback()
            return false
        }
    }
    
    @discardableResult
    public func remove(_ obj: NSManagedObject) -> Bool {
        if let g: Game = obj as? Game { remove(game: g) }
        self.delete(obj)
        return self.store()
    }
    
    private func remove(game: Game, props: [Property] = []) -> Void {
        game.properties.forEach { item in
            if props.doesntContain(item) { item.removeFromGames_nsset(game) }
            if item.games.isEmpty { self.remove(item) }
        }
    }
    
}

extension Context {
    
    @discardableResult
    private func fetchProperties(_ p: Predicate, _ s: [SortDesc]? = nil) -> [Property] {
        let fetchRequest: NSFetchRequest<Property> = Property.fetchRequest()
        fetchRequest.predicate = p
        fetchRequest.sortDescriptors = s
        return (try? self.fetch(fetchRequest)) ?? .init()
    }
    
    @discardableResult
    func fetchProperty(_ builder: PropertyBuilder) -> Property {
        let predicate: CompoundPredicate = .queryForProperty(builder)
        if let property: Property = self.fetchProperties(predicate).first {
            return property
        } else {
            let property: Property = .init(context: self).set(builder)
            self.store()
            return property
        }
        
    }
    
    @discardableResult
    func fetchProperties(_ i: InputEnum, _ str: Binding<String>) -> [Property] {
        let canon: String = str.wrappedValue.canonicalized
        let p1: Predicate = .init(i, .equal)
        let predicate: Predicate = .build(from: p1, canon)
        return self.fetchProperties(predicate, [.init(.value)])
    }
    
}

extension Context {
    
    @discardableResult
    public func fetchGames(_ p: NSPredicate?, _ s: [SortDesc]? = nil) -> [Game] {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = p
        fetchRequest.sortDescriptors = s
        return (try? self.fetch(fetchRequest)) ?? .init()
    }
    
    @discardableResult
    func fetchGame(_ builder: GameBuilder) -> Game? {
        let predicate: CompoundPredicate = .queryForGame(builder)
        return self.fetchGames(predicate).first ?? nil
    }
    
    @discardableResult
    func nsset(_ builder: any GameBuilderProtocol, _ game: Game) -> NSSet {
        let properties: [Property] = builder.builders.map(self.fetchProperty)
        self.remove(game: game, props: properties)
        return .init(properties)
    }
    
}
