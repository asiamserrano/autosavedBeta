//
//  Game+Class.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData

@objc(Game)
public final class Game: NSManagedObject, EntityProtocol {
    
}

extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public private (set) var identity_uuid: UUID?
    @NSManaged public private (set) var raw_title_string: String?
    @NSManaged public private (set) var title_string: String?
    @NSManaged public private (set) var release_date: Date?
    @NSManaged public private (set) var owned_boolean: Bool
    @NSManaged public private (set) var image_data: Data?
    @NSManaged public private (set) var properties_nsset: NSSet?

}

// MARK: Generated accessors for properties_nsset
extension Game {

    @objc(addProperties_nssetObject:)
    @NSManaged public func addToProperties_nsset(_ value: Property)

    @objc(removeProperties_nssetObject:)
    @NSManaged public func removeFromProperties_nsset(_ value: Property)

    @objc(addProperties_nsset:)
    @NSManaged public func addToProperties_nsset(_ values: NSSet)

    @objc(removeProperties_nsset:)
    @NSManaged public func removeFromProperties_nsset(_ values: NSSet)

}

extension Game : Identifiable {
    
    public func set(_ builder: GameBuilder) -> Game {
        self.identity_uuid = .init()
        self.raw_title_string = builder.title.canonicalized
        self.title_string = builder.title.trimmed
        self.release_date = builder.release
        self.owned_boolean = builder.owned
        self.image_data = builder.image
        return self
    }
    
    public func set(_ nsset: NSSet) -> Game {
        self.properties_nsset = nsset
        return self
    }
    
}
