//
//  Game+Class.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData

@objc(Game)
public class Game: NSManagedObject {
    
}

extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var identity_uuid: UUID?
    @NSManaged public var image_data: Data?
    @NSManaged public var owned_boolean: Bool
    @NSManaged public var raw_title_string: String?
    @NSManaged public var release_date: Date?
    @NSManaged public var title_string: String?
    @NSManaged public var properties_nsset: NSSet?

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

}
