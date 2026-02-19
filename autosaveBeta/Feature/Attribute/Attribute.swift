//
//  Attribute.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/14/26.
//

import Foundation
import Core

public enum Attribute {
    
    public enum Enum: Enumerable {
        case input, mode, platform
        
        public enum Builder: Encapsulable {
            case input(Input.Enum)
            case mode, platform
        }
    }
    
    public enum Model {
        case input(Property)
        case mode(Property)
        case platform(Platform)
        
        public var type: Enum {
            switch self {
            case .input: .input
            case .mode: .mode
            case .platform: .platform
            }
        }
        
    }
    
    public enum Builder: BuilderKit.Implementation.Interface {
  
        public typealias Enum = Attribute.Enum.Builder
                    
        case input(Input.Builder)
        case mode(Mode.Enum)
        case platform(Platform.Builder)
        
        public var typeEnum: Self.Enum.Enum {
            self.type.type
        }
        
        public var type: Enum {
            switch self {
            case .input(let i): .input(i.type)
            case .mode: .mode
            case .platform: .platform
            }
        }
        
        public var instance: Instance {
            switch self {
            case .input(let i): return i
            case .mode(let m): return m
            case .platform(let p): return p
            }
        }
        
        public var properties: Property.Builder.Collector {
            switch self {
            case .input(let builder): return .init(.input(builder))
            case .mode(let m): return .init(.mode(m))
            case .platform(let builder): return .init(.system(builder.system), .format(builder.format))
            }
        }
                    
    }
    
}

extension Attribute.Builder {
    
    public static var random: Self {
        .random(Self.Container.Key.random)
    }
    
    public static func random(_ type: Self.Container.Key.Enum) -> Self {
        switch type {
        case .input: return .input(.random)
        case .mode: return .mode(.random)
        case .platform: return .platform(.random)
        }
    }
    
    public static func random(_ key: Self.Container.Key) -> Self {
        switch key {
        case .input(let i): return .input(.random(i))
        case .mode: return .mode(.random)
        case .platform: return .platform(.random)
        }
    }
    
}

//extension Container where Key == Attribute.Builder.Enum, Value == Attribute.Builder.Collector {
//        
//    public typealias E = Value.Element
//    public typealias Enum = Key.Enum
//    
//    public func key(_ e: E) -> Key { e.type }
//    
////    public typealias ValueElement = Value.Element
////    public typealias Collection = ValueElement.Collection
////    public typealias Enum = Collection.Enum
//
//    //    public typealias KeyType =
////    public typealias ValueType = KeyType.Builder
//    
//    
//}

