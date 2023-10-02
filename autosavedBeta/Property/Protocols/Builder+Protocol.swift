//
//  Builder+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public typealias PropertyBuilder = any BuilderProtocol

public protocol BuilderProtocol: PropertyProtocol {
    
    static var typeEnum: TypeEnum { get }
    static var random: Self { get }
    
    init(_ any: any PropertyProtocol)
    
    var display: String { get }
    
}

extension BuilderProtocol {
        
    public var typeEnum: TypeEnum {
        Self.typeEnum
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.get(.primary))
        hasher.combine(self.get(.secondary))
        hasher.combine(self.get(.tertiary))
    }
    
    public func doesEqual(_ other: PropertyBuilder) -> Bool {
        self.hashValue == other.hashValue
    }
    
    public func doesNotEqual(_ other: PropertyBuilder) -> Bool {
        self.hashValue != other.hashValue
    }
        
}
