//
//  Property+Class.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData

@objc(Property)
public final class Property: NSManagedObject, EntityProtocol {

    public static func getKeyPath(_ v: VariableEnum) -> KeyPath<Property, String?> {
        switch v {
        case .primary: return \Self.primary_string
        case .secondary: return \Self.secondary_string
        case .tertiary: return \Self.tertiary_string
        case .value: return \Self.value_string
        }
    }
    
    public static func filter(_ nsset: NSSet, _ t: TypeEnum) -> [Property] {
        Self.transform(nsset).filter(t.equals)
    }
    
    
}

extension Property {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Property> {
        return NSFetchRequest<Property>(entityName: "Property")
    }

    @NSManaged private var primary_string: String?
    @NSManaged private var secondary_string: String?
    @NSManaged private var tertiary_string: String?
    @NSManaged private var value_string: String?
    @NSManaged private var games_nsset: NSSet?
    
    @objc(addGames_nssetObject:)
    @NSManaged public func addToGames_nsset(_ value: Game)

    @objc(removeGames_nssetObject:)
    @NSManaged public func removeFromGames_nsset(_ value: Game)

    @objc(addGames_nsset:)
    @NSManaged public func addToGames_nsset(_ values: NSSet)

    @objc(removeGames_nsset:)
    @NSManaged public func removeFromGames_nsset(_ values: NSSet)

}

extension Property: PropertyProtocol {
    
    public var typeEnum: TypeEnum {
        .init(self.get(.primary))!
    }
    
    public var builder: PropertyBuilder {
        switch self.typeEnum {
        case .input: return InputBuilder(self)
        case .platform: return PlatformBuilder(self)
        case .mode: return ModeBuilder(self)
        }
    }
    
    public func get(_ v: VariableEnum) -> String? {
        switch v {
        case .primary: return self.primary_string
        case .secondary: return self.secondary_string
        case .tertiary: return self.tertiary_string
        case .value: return self.value_string
        }
    }
    
    public func set(_ builder: PropertyBuilder) -> Property {
        self.primary_string = builder.get(.primary)
        self.secondary_string = builder.get(.secondary)
        self.tertiary_string = builder.get(.tertiary)
        self.value_string = builder.get(.value)
        return self
    }
    
}
