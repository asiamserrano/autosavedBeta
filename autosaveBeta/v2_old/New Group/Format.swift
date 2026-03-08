//
//  Format.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

public enum Format {
    
    public enum Identifier: EnumerableRegistryIdentifier {
        case digital, physical
        
        public var registryMembers: Registry.Members {
            switch self {
            case .digital: return Registry.DigitalEnum.cases.map(Registry.digital)
            case .physical: return Registry.PhysicalEnum.cases.map(Registry.physical)
            }
        }
    }
    
    public enum Registry: EnumerableRegistry {

        case digital(DigitalEnum)
        case physical(PhysicalEnum)
        
        public var identifier: Identifier {
            switch self {
            case .digital: return .digital
            case .physical: return .physical
            }
        }
        
        public var rawValue: String {
            switch self {
            case .digital(let d): return d.rawValue
            case .physical(let p): return p.rawValue
            }
        }
        
//        public var anyMember: AnyMember {
//            switch self {
//            case .digital(let d): return d
//            case .physical(let p): return p
//            }
//        }

    }
    
}

extension Format.Registry {
    
    public static func random(_ format: Format.Identifier) -> Self {
        format.registryMembers.random
    }
    
    public static func random(_ system: System.Registry) -> Self {
        system.formatMembers.random
    }
        
    public enum PhysicalEnum: Enumerable {
        case disc, cartridge, card
    }

    public enum DigitalEnum: Enumerable {

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
//
//
//public enum Format {
//    
//    public enum Enum: Enumerable {
//        case digital, physical
//        
//        public var builders: Builder.Cases {
//            switch self {
//            case .digital: return Builder.DigitalEnum.cases.map(Builder.digital)
//            case .physical: return Builder.PhysicalEnum.cases.map(Builder.physical)
//            }
//        }
//    }
//    
//    public enum Builder: Enumerable {
//        
//        public static var allCases: Cases {
//            Format.Enum.cases.flatMap(\.builders)
//        }
//
//        case digital(DigitalEnum)
//        case physical(PhysicalEnum)
//        
//        public var type: Enum {
//            switch self {
//            case .digital: return .digital
//            case .physical: return .physical
//            }
//        }
//        
//        public var rawValue: String {
//            switch self {
//            case .digital(let d): return d.rawValue
//            case .physical(let p): return p.rawValue
//            }
//        }
//
//    }
//    
//}
//
//extension Format.Builder {
//    
//    public static func random(_ format: Format.Enum) -> Self {
//        format.builders.random
//    }
//    
//    public static func random(_ system: System.Builder) -> Self {
//        system.formatBuilders.random
//    }
//        
//    public enum PhysicalEnum: Enumerable {
//        case disc, cartridge, card
//    }
//
//    public enum DigitalEnum: Enumerable {
//
//        case steam, origin, psn, xbox, nintendo, free
//        
//        public var rawValue: String {
//            switch self {
//            case .psn:      return "PlayStation Network"
//            case .xbox:     return "Xbox Live"
//            case .nintendo: return "Nintendo eShop"
//            case .free:     return "DRM-free"
//            case .origin:   return "Origin"
//            case .steam:    return "Steam"
//            }
//        }
//    }
//    
//}

// MARK: --

import SwiftUI

struct FormatView: View {
    
    var body: some View {
        
        NavigationStack {
            Form {
//                EnumerableIdView(Format.Enum.self)
//                EnumerableIdView(Format.Builder.self)
//                EnumerableIdView(Format.Builder.DigitalEnum.self)
//                EnumerableIdView(Format.Builder.PhysicalEnum.self)
            }
        }
        
    }
    
}

#Preview {
    
    FormatView()
    
}
