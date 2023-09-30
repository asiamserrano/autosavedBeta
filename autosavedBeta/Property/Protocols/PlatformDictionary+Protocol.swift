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

extension PlatformDictionaryProtocol {

    public var platformKeys: [PlatformEnum] {
        self.platforms.keys.sorted()
    }
    
    public func getFormats(_ p: PlatformEnum) -> [FormatEnum] {
        self.platforms[p]?.sorted() ?? .init()
    }
    
    public func contains(_ p: PlatformEnum) -> Bool {
        self.platformKeys.contains(p)
    }
    
}
