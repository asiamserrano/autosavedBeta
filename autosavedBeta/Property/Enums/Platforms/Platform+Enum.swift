//
//  File.swift
//  
//
//  Created by Asia Serrano on 9/27/23.
//

import Foundation

public enum PlatformEnum: IterableProtocol {
    
    private static let OS: String = "Operating System"
    
    public enum FamilyEnum: IterableProtocol {
        case nintendo, pc, playstation, xbox

        public var value: String {
            self == .pc ? PlatformEnum.OS : self.defaultValue
        }
        
        public var allPlatforms: [PlatformEnum] {
            switch self {
            case .nintendo: return NintendoEnum.allPlatforms
            case .pc: return PCEnum.allPlatforms
            case .playstation: return PlayStationEnum.allPlatforms
            case .xbox: return XboxEnum.allPlatforms
            }
        }

    }

    public enum TypeEnum: IterableProtocol {
        case handheld, console, hybrid, os

        public var value: String {
            self == .os ? PlatformEnum.OS : self.defaultValue
        }
    }
    
    public static var allCases: [Self] {
        [
            NintendoEnum.allPlatforms,
            PCEnum.allPlatforms,
            PlayStationEnum.allPlatforms,
            XboxEnum.allPlatforms
        ].flatMap { $0 }
    }
  
    case nintendo(NintendoEnum)
    case pc(PCEnum)
    case playstation(PlayStationEnum)
    case xbox(XboxEnum)
    
}

extension PlatformEnum {
    
    private var child: any PlatformProtocol {
        switch self {
        case .nintendo(let n): return n
        case .pc(let pc): return pc
        case .playstation(let ps): return ps
        case .xbox(let x): return x
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.className)
        hasher.combine(self.child.className)
        hasher.combine(self.child.key)
    }
    
    public var key: String {
        self.child.key
    }
    
    public var value: String {
        self.child.value
    }
    
    public var typeEnum: PlatformType {
        self.child.typeEnum
    }
    
    public var physical: FormatEnum { .physical(self.child.physicalFormat) }
    public var digital: [FormatEnum] { self.child.digitalFormats.map (FormatEnum.digital) }
    
}

