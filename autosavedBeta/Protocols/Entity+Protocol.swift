//
//  Entity+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public protocol EntityProtocol: IdentifiableProtocol {
    
    static func transform(_ nsset: NSSet) -> [Self]
    static func transform(_ array: [Self]) -> NSSet
    
}

extension EntityProtocol {
    
    public static func transform(_ nsset: NSSet) -> [Self] {
        nsset.filter { $0 is Self }.map { $0 as! Self }
    }
    
    public static func transform(_ array: [Self]) -> NSSet {
        .init(array: array)
    }
    
}
