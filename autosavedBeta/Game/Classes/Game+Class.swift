//
//  Game+Class.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData
import SwiftUI

public typealias GameVariable = Game.VariableEnum

@objc(Game)
public final class Game: NSManagedObject {
    
    public enum VariableEnum: String {
        case raw = "raw_title_string"
        case title = "title_string"
        case release = "release_date"
        case owned = "owned_boolean"
        case properties = "properties_nsset"
        case identity = "identity_uuid"
    }
    
    public func update(_ con: Context, _ builder: GameBuilder) -> Game {
        self.identity_uuid = builder.uuid
        self.raw_title_string = builder.title.canonicalized
        self.title_string = builder.title.trimmed
        self.release_date = builder.release
        self.owned_boolean = builder.owned
        self.image_data = builder.image
        self.properties_nsset = con.createNSSet(self, builder)
        return self.save(con)
    }
    
    public static var rawKeyPath: KeyPath<Game, String?> {
        return \Self.raw_title_string
    }
    
    public static var releaseKeyPath: KeyPath<Game, Date?> {
        return \Self.release_date
    }
    
    public static var ownedKeyPath: KeyPath<Game, Bool> {
        return \Self.owned_boolean
    }

    public override var string: String {
        "\(self.title) (\(self.release.dashes))"
    }
    
    public override var tuple: NSManagedObject.ObjectTuple {
        .init(self.title, self.release.dashes)
    }
    
    private func save(_ con: Context) -> Game {
        con.store()
        return self
    }

}

extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged private var identity_uuid: UUID?
    @NSManaged private var raw_title_string: String?
    @NSManaged private var title_string: String?
    @NSManaged private var release_date: Date?
    @NSManaged private var owned_boolean: Bool
    @NSManaged private var image_data: Data?
    @NSManaged private var properties_nsset: NSSet?

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
    
    public static var entityEnum: EntityEnum { .game }

    public var uuid: UUID {
        if let u: UUID = self.identity_uuid {
            return u
        } else {
            let new: UUID = .init()
            self.identity_uuid = new
            return new
        }
    }
    
    public var alertString: String {
        "\(self.title) (\(self.release.year))"
    }
    
    public var title: String {
        self.title_string ?? .empty
    }
    
    public var release: Date {
        self.release_date ?? .today
    }
    
    public var builders: [PropertyBuilder] {
        self.properties.map { $0.builder }
    }

    public var properties: [Property] {
        self.properties_nsset?.map { $0 as! Property } ?? .init()
    }
    
    public var status: Bool { self.owned_boolean }
    public var image: Data? { self.image_data }
    public var uuidString: String { self.uuid.uuidString }
    
}
