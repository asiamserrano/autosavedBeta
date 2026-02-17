////
////  Attribute+Builder.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/11/26.
////
//
//import Foundation
//import Core
//
//extension Attribute.Builder {
//    
////    public typealias Model = Generic.Attribute.Model
////    
////    public init(model: Model) {
////        fatalError("Unable to cast model to attribute builder")
////    }
//    
////    public static func property(_ builder: Property.Builder) -> Self {
////        fatalError("Unable to cast property builder to attribute builder")
////    }
////    
////    public var modelType: Generic.Model.Enum {
////        self.attributeType.modelType
////    }
////
////    public var compoundKey: Compound.Key {
////        switch self {
////        case .input(let builder): return .init(key: self.attributeType.id, value: builder.compoundKey.yoke)
////        case .mode(let m): return .init(key: self.attributeType.id, value: m.yoke)
////        case .platform(let builder): return .init(key: self.attributeType.id, value: builder.compoundKey.yoke)
////        }
////    }
////    
////    public var rawValue: String {
////        switch self {
////        case .input(let builder): return builder.rawValue
////        case .mode(let m): return m.rawValue
////        case .platform(let builder): return builder.rawValue
////        }
////    }
////    
////    public var attributeType: Generic.Attribute.Enum {
////        self.attributeBuilderType.attributeType
////    }
////
////    public var attributeBuilderType: Enum.Builder {
////        switch self {
////        case .input(let i): return .input(i.type)
////        case .mode: return .mode
////        case .platform: return .platform
////        }
////    }
////    
//    public var properties: Property.Builder.Collection {
//        switch self {
//        case .input(let builder): return .init(.input(builder))
//        case .mode(let m): return .init(.mode(m))
//        case .platform(let builder): return .init(.system(builder.system), .format(builder.format))
//        }
//    }
//    
//}
