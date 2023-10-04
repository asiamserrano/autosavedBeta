////
////  PlatformDictionary+Protocol.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////

import Foundation

public protocol PlatformDictionaryProtocol {
        
    var platforms: [PlatformEnum: [FormatEnum]] { get }
    
    func removePlatform(_ index: Int) -> Void
    func removeFormat(_ key: PlatformEnum, _ index: Int) -> Void
    
    func insertPlatform(_ p: PlatformEnum, _ f: [FormatEnum]) -> Void
}

public extension PlatformDictionaryProtocol {

    var platformKeys: [PlatformEnum] {
        self.platforms.keys.sorted()
    }
    
    var isPlatformsEmpty: Bool { self.platformKeys.isEmpty }
    
    func getFormats(_ p: PlatformEnum) -> [FormatEnum] {
        self.platforms[p]?.sorted() ?? .init()
    }
    
    func contains(_ p: PlatformEnum) -> Bool {
        self.platformKeys.contains(p)
    }
    
//    func isPlatformEmpty(_ p: PlatformEnum) -> Bool {
//        self.getFormats(p).isEmpty
//    }
//    
}
