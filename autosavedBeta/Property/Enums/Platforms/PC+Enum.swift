//
//  File.swift
//  
//
//  Created by Asia Serrano on 9/27/23.
//

import Foundation


public enum PCEnum: PlatformProtocol {
    
    public static var family: PlatformFamily { .pc }
    
    public static var allPlatforms: [PlatformEnum] {
        Self.all.map(PlatformEnum.pc)
    }

    case win, mac
    
    public var value: String {
        self == .mac ? "Apple macOS" : "Microsoft Windows"
    }
    
    public var typeEnum: PlatformType { .os }
    
    public var digitalFormats: [DigitalEnum] {
        [.steam, .origin, .file]
    }
    
}

