//
//  System.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

public struct System {
    
    public enum Identifier: EnumerableRegistryIdentifier {
            
        case playstation, nintendo, xbox, os
        
        public var registryMembers: Registry.Members {
            switch self {
              case .playstation:
                return Registry.PlayStationEnum.cases.map(Registry.playstation)
              case .nintendo:
                return Registry.NintendoEnum.cases.map(Registry.nintendo)
            case .xbox:
                return Registry.XboxEnum.cases.map(Registry.xbox)
            case .os:
                return Registry.OSEnum.cases.map(Registry.os)
            }
        }

    }
    
    public enum Registry: EnumerableRegistry {
        case playstation(PlayStationEnum)
        case nintendo(NintendoEnum)
        case xbox(XboxEnum)
        case os(OSEnum)

        public var identifier: Identifier {
            switch self {
            case .playstation: return .playstation
            case .nintendo: return .nintendo
            case .os: return .os
            case .xbox: return .xbox
            }
        }
        
        public var rawValue: String {
            switch self {
            case .playstation(let p): return p.rawValue
            case .nintendo(let n): return n.rawValue
            case .xbox(let x): return x.rawValue
            case .os(let o): return o.rawValue
            }
        }
        
//        public var anyMember: AnyMember {
//            switch self {
//            case .playstation(let p): return p
//            case .nintendo(let n): return n
//            case .xbox(let x): return x
//            case .os(let o): return o
//            }
//        }
        
    }
    
}

extension System.Identifier {
    
    public var rawValue: String {
        switch self {
        case .playstation: return "PlayStation"
        case .nintendo: return "Nintendo"
        case .xbox: return "Xbox"
        case .os: return "Operating System"
        }
    }
    
    public var title: String {
        switch self {
        case .os:
            return self.rawValue.pluralize()
        default:
            return "\(self.rawValue) Systems"
        }
    }
    
}

extension System.Registry {
    
    public typealias FormatMember = Format.Registry.Member
    public typealias FormatMembers = Format.Registry.Members
        
    public enum PlayStationEnum: Enumerable {
        
        case ps1, ps2, ps3, ps4, ps5, psp
        
        public var rawValue: String {
            switch self {
            case .ps1: return "PlayStation"
            case .ps2: return "PlayStation 2"
            case .ps3: return "PlayStation 3"
            case .ps4: return "PlayStation 4"
            case .ps5: return "PlayStation 5"
            case .psp: return "PlayStation Portable"
            }
        }
    }
    
    public enum NintendoEnum: Enumerable {
        
        case snes, nsw, wii, wiiu, gamecube, n3ds
        
        public var rawValue: String {
            switch self {
            case .snes: return "Super Nintendo Entertainment System"
            case .nsw: return "Nintendo Switch"
            case .wii: return "Wii"
            case .wiiu : return "Wii U"
            case .gamecube: return "GameCube"
            case .n3ds: return "Nintendo 3DS"
            }
        }
    }
    
    public enum OSEnum: Enumerable {

        case mac, win
        
        public var rawValue: String {
            switch self {
            case .mac: return "Apple macOS"
            case .win: return "Microsoft Windows"
            }
        }
    }
    
    public enum XboxEnum: Enumerable {

        case xbox, x360, one
        
        public var rawValue: String {
            switch self {
            case .xbox: return "Xbox"
            case .x360: return "Xbox 360"
            case .one:  return "Xbox One"
            }
        }
    }
    
    public var physicalMember: FormatMember {
        switch self {
        case .nintendo(let nintendo):
            switch nintendo {
            case .snes:
                return .physical(.cartridge)
            case .nsw, .n3ds:
                return .physical(.card)
            default:
                return .physical(.disc)
            }
        default:
            return .physical(.disc)
        }
    }
    
    public var digitalMembers: FormatMembers {
        let free: FormatMember = .digital(.free)
        switch self {
        case .playstation(let playstation):
            switch playstation {
            case .ps3, .ps4, .ps5:
                let p: FormatMember = .digital(.psn)
                return .init(free, p)
            case .psp:
                return .init(free)
            default:
                return .defaultValue
            }
        case .nintendo(let nintendo):
            switch nintendo {
            case .nsw:
                let n: FormatMember = .digital(.nintendo)
                return .init(n)
            default:
                return .defaultValue
            }
        case .xbox(let xbox):
            switch xbox {
            case .x360, .one:
                let x: FormatMember = .digital(.xbox)
                return .init(free, x)
            default:
                return .defaultValue
            }
        case .os:
            let steam: FormatMember = .digital(.steam)
            let origin: FormatMember = .digital(.origin)
            return .init(steam, origin, free)
        }
    }
    
    public var formatMembers: FormatMembers {
        digitalMembers.union(physicalMember)
    }
    
//    public var platformBuilders: Platform.Registry.Cases {
//        .defaultValue
////        self.formatBuilders.compactMap { .init(system: self, format: $0) }
//    }
    
}
