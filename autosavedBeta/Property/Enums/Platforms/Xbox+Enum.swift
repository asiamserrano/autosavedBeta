//
//  File.swift
//  
//
//  Created by Asia Serrano on 9/27/23.
//

import Foundation


public enum XboxEnum: PlatformProtocol {
    
    public static var family: PlatformFamily { .xbox }
    
    public static var allPlatforms: [PlatformEnum] {
        Self.all.map(PlatformEnum.xbox)
    }
    
    case xbox, x360, one
    
    public var value: String {
        var end: String {
            switch self {
            case .xbox: return .empty
            case .x360: return "360"
            case .one: return "One"
            }
        }
        
        return "\(Self.family.value) \(end)".trimmed
    }
    
    public var typeEnum: PlatformType { .console }
    
    public var digitalFormats: [DigitalEnum] {
        self == .xbox ? [] : [.xbox, .file]
    }
    
}
