//
//  Attribute+Enum.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core
import Core

extension Attribute.Enum {
    
    public var builderCases: Builder.Cases {
        switch self {
        case .input: return Input.Enum.cases.map { .input($0) }
        case .mode: return .init(.mode)
        case .platform: return .init(.platform)
        }
    }
    
}

extension Attribute.Enum.Builder {
    
    public typealias Enum = Attribute.Enum
    
    public static var allCases: Cases { Enum.cases.flatMap(\.builderCases) }

    public var enumeror: Enumeror {
        switch self {
        case .input(let i): return i
        default: return self.type
        }
    }
    
    public var type: Enum {
        switch self {
        case .input: return .input
        case .mode: return .mode
        case .platform: return .platform
        }
    }
    
}

//extension Attribute.Enum {
//    
//    public enum Builder: Encapsulable {
//        case input(Input.Enum)
//        case mode, platform
//    }
//    
//    public var builderCases: Builder.Cases {
//        switch self {
//        case .input: return Input.Enum.cases.map { .input($0) }
//        case .mode: return .init(.mode)
//        case .platform: return .init(.platform)
//        }
//    }
//    
////    public var modelType: Generic.Model.Enum {
////        switch self {
////        case .platform: return .platform
////        default: return .property
////        }
////    }
//    
//    
//}
//
//extension Attribute.Enum.Builder {
//    
//    
//    public static var allCases: Cases { Attribute.Enum.cases.flatMap(\.builderCases) }
//    
//
//    public var enumeror: Enumeror {
//        switch self {
//        case .input(let i): return i
//        default: return self.type
//        }
//    }
//    
//    public var type: Attribute.Enum {
//        switch self {
//        case .input: return .input
//        case .mode: return .mode
//        case .platform: return .platform
//        }
//    }
//    
//}
