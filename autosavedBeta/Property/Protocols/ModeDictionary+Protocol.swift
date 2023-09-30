//
//  ModeDictionary+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

public protocol ModeDictionaryProtocol {
    
    var modes: [ModeEnum] { get }
    
    func insertMode(_ m: ModeEnum) -> Void
    func removeMode(_ m: ModeEnum) -> Void
    
}

extension ModeDictionaryProtocol {
    
    public func contains(_ m: ModeEnum) -> Bool {
        self.modes.contains(m)
    }
    
}
