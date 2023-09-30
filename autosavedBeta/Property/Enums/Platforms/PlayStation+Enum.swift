//
//  File.swift
//  
//
//  Created by Asia Serrano on 9/27/23.
//

import Foundation


public enum PlayStationEnum: PlatformProtocol {
    
    public static var family: PlatformFamily { .playstation }
    
    public static var allPlatforms: [PlatformEnum] {
        Self.all.map(PlatformEnum.playstation)
    }

    case ps1, ps2, ps3, ps4, ps5, psp
    
    public var value: String {
        
        var end: String {
            if let ch: Character = self.key.last, let i: Int = Int(String(ch)) {
                return i == 1 ? .empty : i.description
            } else { return "Portable" }
        }
        
        return "\(Self.family.value) \(end)".trimmed
    }
    
    public var typeEnum: PlatformType {
        self == .psp ? .handheld : .console
    }
    
    public var digitalFormats: [DigitalEnum] {
        switch self {
        case .psp: return [.file]
        case .ps1, .ps2: return []
        default: return [.psn, .file]
        }
    }
    
}
