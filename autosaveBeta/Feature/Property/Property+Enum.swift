//
//  Property+Enum.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Property.Enum {
    
    public var builderCases: Builder.Cases {
        switch self {
        case .input: return Input.Enum.cases.map { Builder.input($0) }
        case .mode: return .init(.mode)
        case .system: return System.Enum.cases.map { Builder.system($0) }
        case .format: return Format.Enum.cases.map { Builder.format($0) }
        }
    }
    
}

extension Property.Enum.Builder {
    
    public static var allCases: Cases { Property.Enum.cases.flatMap(\.builderCases) }
    
    public var enumeror: Enumeror {
        switch self {
        case .input(let i): return i
        case .mode: return self.type
        case .system(let s): return s
        case .format(let f): return f
        }
    }
    
    public var type: Property.Enum {
        switch self {
        case .input: return .input
        case .mode: return .mode
        case .system: return .system
        case .format: return .format
        }
    }
    
    
}
