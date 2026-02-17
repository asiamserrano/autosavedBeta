//
//  Platform+Model.swift
//  AutoSaveMock
//
//  Created by Asia Serrano on 2/1/26.
//

import Foundation
import SwiftData
import Core

@Model
public final class Platform: ModelKit.Model.Interface {
    
    @Relationship(inverse: \Property.platforms)
    public var properties: [Property] = [] // Initialize array to prevent potential bugs
    public private(set) var games: [Game] = []
    public private(set) var uuid: UUID
    public private(set) var compound_key: String
    
    public init() {
        self.uuid = .init()
        self.compound_key = .defaultValue
    }
    
    public convenience init(builder: Builder) {
        self.init()
    }

    public var builder: Builder {
        .random
    }
        
//
//    public struct Builder {
//        public let system: System.Builder
//        public let format: Format.Builder
//    }

    
//    private init(uuid: UUID?, properties: PropertyArray = .defaultValue, key: String = .defaultValue) {
//        self.uuid = uuid ?? .init()
//        self.properties = properties
//        self.compound_key = key
//    }
//    
//    public convenience init(builder: Builder, map: [Property.Builder: Property], _ uuid: UUID? = nil) {
//        if let primary = map[.system(builder.system)], let secondary = map[.format(builder.format)] {
//            let properties = [primary, secondary]
//            let key = builder.compoundKey.yoke
//            self.init(uuid: uuid, properties: properties, key: key)
//        } else {
//            self.init(uuid: uuid)
//        }
//    }
//    
//    public convenience init(_ primary: Property?, _ secondary: Property?, _ uuid: UUID? = nil) {
//        if let p = primary, let s = secondary, let system = p.builder.asEnumerable(SystemBuilder.self), let format = s.builder.asEnumerable(FormatBuilder.self) {
//            let builder: Builder = .init(system: system, format: format)
//            let map: [Property.Builder: Property] = [p.builder: p, s.builder: s]
//            self.init(builder: builder, map: map)
//        } else {
//            self.init(uuid: uuid)
//        }
//    }
//    
//    public convenience init(builder: Builder) {
//        self.init(uuid: nil)
//    }

//    public var system: Property? { self.get(.system) }
//    public var format: Property? { self.get(.format) }
//    public var systemBuilder: SystemBuilder { self.builder.system }
//    public var formatBuilder: FormatBuilder { self.builder.format }
//    
//    private func get(_ key: Property.Key) -> Property? {
//        self.properties.first(where: { $0.key == key })
//    }
//    
////    public var attribute: Generic.Attribute.Model { .platform(self) }
//    
//    public var model: Generic.Model { .platform(self) }

    
}
