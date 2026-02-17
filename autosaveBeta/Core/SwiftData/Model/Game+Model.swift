//
//  Game+Model.swift
//  AutoSaveMock
//
//  Created by Asia Serrano on 1/26/26.
//

import Foundation
import SwiftData
import Combine
import SwiftUI
import Core

@Model
public final class Game: ModelKit.Model.Interface {
    
    @Attribute(.unique)
    public private(set) var uuid: UUID
    @Attribute(.unique)
    public private(set) var compound_key: String
    
    public private(set) var added: Date
    public private(set) var title: String
    public private(set) var release: Date
    public private(set) var status_bool: Bool
    public private(set) var boxart: Data?
    
    @Relationship(inverse: \Property.games)
    public var properties: [Property] = [] // Initialize array to prevent potential bugs
    @Relationship(inverse: \Platform.games)
    public var platforms: [Platform] = [] // Initialize array to prevent potential bugs
    
    public init() {
        self.added = .defaultValue
        self.title = .defaultValue
        self.release = .defaultValue
        self.status_bool = .defaultValue
        self.boxart = nil
        self.compound_key = .defaultValue
        self.uuid = .init()
    }
    
    public init(uuid: UUID, builder: Builder) {
        self.added = builder.added
        self.title = builder.title
        self.release = builder.release
        self.status_bool = builder.status_bool
        self.boxart = builder.boxart
        self.compound_key = builder.compound_key
        self.uuid = uuid
    }
    
    public convenience init(builder: Builder) {
        self.init(uuid: .init(), builder: builder)
    }
    
    public var builder: Builder {
        .init(title: self.title, release: self.release, status: self.status_bool, boxart: self.boxart, added: self.added)
    }
 
//    public required init(builder: Builder) {
//        self.uuid = builder.uuid
//        self.added = builder.added
//        self.title = builder.title
//        self.release = builder.release
//        self.status_bool = builder.status.bool
//        self.boxart = builder.boxart
//        self.compound_key = builder.compoundKey.rawValue
//    }
    
//    public var model: Generic.Model { .game(self) }
        
}

//extension Game: GameObjectProtocol {
//    
//    public var status: Game.Status { .init(self.status_bool) }
//    
//    public var attributes: Attributes {
//        .defaultValue
////        self.properties.collection.union(self.platforms.collection)
//    }
//    
//}
