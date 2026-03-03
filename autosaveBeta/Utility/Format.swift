//
//  Format.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

public enum Format {
    
    public enum Enum: Enumerable.Enum.Interface {
        case digital, physical
        
        public var builders: Builder.Cases {
            switch self {
            case .digital: return Builder.DigitalEnum.cases.map(Builder.digital)
            case .physical: return Builder.PhysicalEnum.cases.map(Builder.physical)
            }
        }
    }
    
    public enum Builder: Enumerable.Enum.Builder.Interface {

        case digital(DigitalEnum)
        case physical(PhysicalEnum)
        
        public var type: Enum {
            switch self {
            case .digital: return .digital
            case .physical: return .physical
            }
        }
        
        public var instance: Instance {
            switch self {
            case .digital(let d): return d
            case .physical(let p): return p
            }
        }

    }
    
}

extension Format.Builder {
    
    public static func random(_ format: Enum) -> Self {
        format.builders.random
    }
    
    public static func random(_ system: System.Builder) -> Self {
        system.formatBuilders.random
    }
        
    public enum PhysicalEnum: Enumerable.Interface {
        case disc, cartridge, card
    }

    public enum DigitalEnum: Enumerable.Interface {

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
    
}
