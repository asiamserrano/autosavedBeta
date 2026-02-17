//
//  System.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

public struct System {
    
    public enum Enum: Enumerable {
            
        case playstation, nintendo, xbox, os
        
        public var builders: Builder.Cases {
            switch self {
              case .playstation:
                return Builder.PlayStationEnum.systems
              case .nintendo:
                return Builder.NintendoEnum.systems
            case .xbox:
                return Builder.XboxEnum.systems
            case .os:
                return Builder.OSEnum.systems
            }
        }
        
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
    
    public enum Builder: Encapsulable {
        
        public static var allCases: Cases {
            Enum.allCases.flatMap(\.builders)
        }
        
        case playstation(PlayStationEnum)
        case nintendo(NintendoEnum)
        case xbox(XboxEnum)
        case os(OSEnum)

        public var enumeror: Enumeror {
            switch self {
            case .playstation(let p): return p
            case .nintendo(let n): return n
            case .xbox(let x): return x
            case .os(let o): return o
            }
        }
        
    }
    
}

extension System.Builder {
    
    public typealias Builder = System.Builder
    public typealias Enum = System.Enum
    public typealias FormatBuilder = Format.Builder
    
    public enum PlayStationEnum: Enumerable {
        
        public static var systems: Builder.Cases {
            Self.cases.map(Builder.playstation)
        }
        
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
        
        public static var systems: Builder.Cases {
            Self.cases.map(Builder.nintendo)
        }
        
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
        
        public static var systems: Builder.Cases {
            Self.cases.map(Builder.os)
        }
        
        case mac, win
        
        public var rawValue: String {
            switch self {
            case .mac: return "Apple macOS"
            case .win: return "Microsoft Windows"
            }
        }
    }
    
    public enum XboxEnum: Enumerable {
        
        public static var systems: Builder.Cases {
            Self.cases.map(Builder.xbox)
        }
        
        case xbox, x360, one
        
        public var rawValue: String {
            switch self {
            case .xbox: return "Xbox"
            case .x360: return "Xbox 360"
            case .one:  return "Xbox One"
            }
        }
    }
    
    public var system: Enum {
        switch self {
        case .playstation: return .playstation
        case .nintendo: return .nintendo
        case .os: return .os
        case .xbox: return .xbox
        }
    }
    
    public var physicalBuilder: FormatBuilder {
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
    
    public var digitalBuilders: FormatBuilder.Cases {
        let free: FormatBuilder = .digital(.free)
        switch self {
        case .playstation(let playstation):
            switch playstation {
            case .ps3, .ps4, .ps5:
                let p: FormatBuilder = .digital(.psn)
                return .init(free, p)
            case .psp:
                return .init(free)
            default:
                return .defaultValue
            }
        case .nintendo(let nintendo):
            switch nintendo {
            case .nsw:
                let n: FormatBuilder = .digital(.nintendo)
                return .init(n)
            default:
                return .defaultValue
            }
        case .xbox(let xbox):
            switch xbox {
            case .x360, .one:
                let x: FormatBuilder = .digital(.xbox)
                return .init(free, x)
            default:
                return .defaultValue
            }
        case .os:
            let steam: FormatBuilder = .digital(.steam)
            let origin: FormatBuilder = .digital(.origin)
            return .init(steam, origin, free)
        }
    }
    
    public var formatBuilders: FormatBuilder.Cases {
        digitalBuilders.union(physicalBuilder)
    }
    
    public var platformBuilders: Platform.Builder.Cases {
        .defaultValue
//        self.formatBuilders.compactMap { .init(system: self, format: $0) }
    }
    
}

