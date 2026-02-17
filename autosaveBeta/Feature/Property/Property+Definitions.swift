//
//  Property+Definitions.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Property {
    
    public enum Enum: Enumerable {
        case input, mode, system, format
        
        public enum Builder: Encapsulable {
            case input(Input.Enum)
            case mode
            case system(System.Enum)
            case format(Format.Enum)
        }
        
    }
    
    public enum Builder: ModelKit.Model.Builder.Interface {
        
        public static var random: Self { .random(.random) }

        public static func random(_ type: Property.Enum) -> Self {
            switch type {
            case .input: return .input(.random)
            case .mode: return .mode(.random)
            case .system: return .system(.random)
            case .format: return .format(.random)
            }
        }
        
        public typealias Model = Property
        public typealias Enum = Property.Enum.Builder
                
        case input(Input.Builder)
        case mode(Mode.Enum)
        case system(System.Builder)
        case format(Format.Builder)
        
        public var type: Self.Enum {
            switch self {
            case .input(let i): return .input(i.type)
            case .mode: return .mode
            case .system(let s): return .system(s.system)
            case .format(let f): return .format(f.format)
            }
        }
        
        public var compound: Compound {
            .init(storage: .defaultValue)
        }
        
    }
    
}

extension Property.Builder: BuilderKit.Implementation.Interface {
    
    public var instance: Instance {
        switch self {
        case .input(let i): return i
        case .mode(let m): return m
        case .system(let s): return s
        case .format(let f): return f
        }
    }
    
}
