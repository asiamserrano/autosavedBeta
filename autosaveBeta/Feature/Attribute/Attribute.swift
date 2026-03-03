////
////  Attribute.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/14/26.
////
//
//import Foundation
//import Core
//
//public enum Attribute {
//    
//    public enum Enum: Enumerable.Enum.Interface {
//        case input, mode, platform
//        
//        public enum Builder: Enumerable.Enum.Builder.Interface {
//            case input(Input.Enum)
//            case mode, platform
//        }
//    }
//    
////    public enum Model {
////        case input(Property)
////        case mode(Property)
////        case platform(Platform)
////        
////        public var type: Enum {
////            switch self {
////            case .input: .input
////            case .mode: .mode
////            case .platform: .platform
////            }
////        }
////        
////    }
//    
//    public enum Builder: BuilderKit.Implementation.Interface {
//        case input(Input.Builder)
//        case mode(Mode.Enum)
//        case platform(Platform.Builder)
//    }
//    
//}
//
////extension Container where Key == Attribute.Builder.Enum, Value == Attribute.Builder.Collector {
////        
////    public typealias E = Value.Element
////    public typealias Enum = Key.Enum
////    
////    public func key(_ e: E) -> Key { e.type }
////    
//////    public typealias ValueElement = Value.Element
//////    public typealias Collection = ValueElement.Collection
//////    public typealias Enum = Collection.Enum
////
////    //    public typealias KeyType =
//////    public typealias ValueType = KeyType.Builder
////    
////    
////}
//
