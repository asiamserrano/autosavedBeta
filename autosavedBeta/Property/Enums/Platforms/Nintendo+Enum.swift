//
//  File.swift
//  
//
//  Created by Asia Serrano on 9/27/23.
//

import Foundation

public enum NintendoEnum: PlatformProtocol {
    
    public static var family: PlatformFamily { .nintendo }
    
    public static var allPlatforms: [PlatformEnum] {
        Self.all.map(PlatformEnum.nintendo)
    }
            
    case snes, `switch`, wii, wiiu, gamecube, n3ds
    
    public var value: String {
        let name: String = Self.family.value
        switch self {
        case .snes: return "Super \(name) Entertainment System"
        case .switch: return "\(name) Switch"
        case .wii: return "Wii"
        case .wiiu : return "Wii U"
        case .gamecube: return "GameCube"
        case .n3ds: return "\(name) 3DS"
        }
    }
    
    public var typeEnum: PlatformType {
        switch self {
        case .n3ds: return .handheld
        case .switch, .wiiu: return .hybrid
        default: return .console
        }
    }
    
    public var physicalFormat: PhysicalEnum {
        switch self {
        case .snes: return .cartridge
        case .switch, .n3ds: return .card
        default: return .disc
        }
    }

    public var digitalFormats: [DigitalEnum] {
        switch self {
        case .n3ds, .gamecube, .snes: return []
        default: return [.nintendo, .file]
        }
    }
    
}

