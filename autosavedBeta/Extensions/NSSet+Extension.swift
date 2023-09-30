//
//  NSSet+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

fileprivate enum SetEnum: IterableProtocol {
    case property
    case input
    case mode
    case platform
    case builder
    
    public func cast(_ any: Any) -> Bool {
        switch self {
        case .property: return any is Property
        case .input: return any is InputBuilder
        case .mode: return any is ModeBuilder
        case .platform: return any is PlatformBuilder
        case .builder: return any is NSSet.Builder
        }
    }
    
}

extension NSSet {
    
    public typealias Identifiable = any IdentifiableProtocol
    public typealias Builder = any BuilderProtocol
    
    
    private func equals(_ obj1: Identifiable, _ obj2: Element) -> Bool {
        if let obj: Identifiable = obj2 as? Identifiable, type(of: obj1) == type(of: obj) {
            return obj1.hashValue == obj.hashValue
        } else { return false }
    }
    
    private func filter(_ e: SetEnum) -> [Element] {
        self.allObjects.filter(e.cast)
    }
    
    public func insert(_ obj: Identifiable) -> Self {
        .init(array: (self.contains(obj) ? self.remove(obj) : self).allObjects + [obj])
    }
    
    public func remove(_ obj: Identifiable) -> Self {
        .init(array: self.allObjects.filter { !equals(obj, $0) })
    }
    
}

extension NSSet {
    
    public func build(_ con: Context) -> [Property] {
        self.filter(.builder).map { con.fetchProperty($0 as! Builder) }
    }
    
    public func filterInputs(_ i: InputEnum) -> [InputBuilder] {
        self.filter(.input).map { $0 as! InputBuilder }.filter { $0.inputEnum == i }
    }
    
    public func filterModes() -> [ModeBuilder] {
        self.filter(.mode).map { $0 as! ModeBuilder }
    }
    
    public func filterModes() -> [PlatformBuilder] {
        self.filter(.platform).map { $0 as! PlatformBuilder }
    }
    
}
