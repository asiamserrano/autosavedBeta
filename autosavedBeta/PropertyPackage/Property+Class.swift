//
//  Property+Class.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData

@objc(Property)
public class Property: NSManagedObject {

}

extension Property {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Property> {
        return NSFetchRequest<Property>(entityName: "Property")
    }

    @NSManaged public var primary_string: String?
    @NSManaged public var secondary_string: String?
    @NSManaged public var tertiary_string: String?
    @NSManaged public var value_string: String?
    @NSManaged public var games_nsset: NSSet?

}

// MARK: Generated accessors for games_nsset
extension Property {

    @objc(addGames_nssetObject:)
    @NSManaged public func addToGames_nsset(_ value: Game)

    @objc(removeGames_nssetObject:)
    @NSManaged public func removeFromGames_nsset(_ value: Game)

    @objc(addGames_nsset:)
    @NSManaged public func addToGames_nsset(_ values: NSSet)

    @objc(removeGames_nsset:)
    @NSManaged public func removeFromGames_nsset(_ values: NSSet)

}

extension Property : Identifiable {

}
