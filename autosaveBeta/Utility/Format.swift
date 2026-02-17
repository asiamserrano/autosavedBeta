//
//  Format.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

public struct Format {
    
    public enum Enum: Enumerable {
        case digital, physical
        
        public var builders: Builder.Cases {
            switch self {
            case .digital: return Builder.DigitalEnum.builders
            case .physical: return Builder.PhysicalEnum.builders
            }
        }
        
    }
    
    public enum Builder: Encapsulable {
        
        public static var allCases: Cases {
            Enum.allCases.flatMap(\.builders)
        }
        
        case digital(DigitalEnum)
        case physical(PhysicalEnum)
        
        public var enumeror: Enumeror {
            switch self {
            case .digital(let d): return d
            case .physical(let p): return p
            }
        }

    }

    
}

extension Format.Builder {
    
    public typealias Builder = Format.Builder
    public typealias Enum = Format.Enum
    
    public static func random(_ format: Enum) -> Self {
        format.builders.random
    }
    
    public static func random(_ system: System.Builder) -> Self {
        system.formatBuilders.random
    }
    
    public enum PhysicalEnum: Enumerable {
        
        public static var builders: Builder.Cases {
            Self.cases.map(Builder.physical)
        }
        
        case disc, cartridge, card
    }

    public enum DigitalEnum: Enumerable {
        
        public static var builders: Builder.Cases {
            Self.cases.map(Builder.digital)
        }
        
        case steam, origin, psn, xbox, nintendo, free
        
        public var rawValue: String {
            switch self {
            case .psn:      return "PlayStation Network"
            case .xbox:     return "Xbox Live"
            case .nintendo: return "Nintendo eShop"
            case .free:     return "DRM-free"
            case .origin:   return "Origin"
            case .steam:    return "Steam"
            }
        }
    }
    
    public var format: Enum {
        switch self {
        case .digital: return .digital
        case .physical: return .physical
        }
    }
    
}
