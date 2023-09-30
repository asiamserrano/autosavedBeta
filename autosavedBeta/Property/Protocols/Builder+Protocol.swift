//
//  Builder+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public protocol BuilderProtocol: PropertyProtocol {
    
    static var typeEnum: TypeEnum { get }
    
    init(_ any: any PropertyProtocol)
    
}

extension BuilderProtocol {
    
    public var typeEnum: TypeEnum {
        Self.typeEnum
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.get(.primary))
        hasher.combine(self.get(.secondary))
        hasher.combine(self.get(.tertiary))
//        hasher.combine(self.get(.value))
    }
    
    public func insertTo(_ arr: [Self]) -> [Self] {
        [self] + (self.existsIn(arr) ? self.removeFrom(arr) : arr)
    }
    
    public func existsIn(_ arr: [Self]) -> Bool {
        arr.contains(where: self.equalsTo)
    }
    
    public func removeFrom(_ arr: [Self]) -> [Self] {
        arr.filter { !self.equalsTo($0) }
    }
    
    public func equalsTo(_ other: Self) -> Bool {
        self.hashValue == other.hashValue
    }
    
//    public func filter(_ arr: [any PropertyProtocol]) -> [Self] {
//        arr.filter(self.typeEnum.equals).map(Self.init)
//    }
    
}
