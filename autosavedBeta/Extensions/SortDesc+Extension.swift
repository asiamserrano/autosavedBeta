//
//  SortDesc+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation
import CoreData
import SwiftUI

public typealias SortDesc = NSSortDescriptor

extension SortDesc {
    
    public convenience init(_ v: PropertyVariable, _ asc: Bool = true) {
        self.init(keyPath: Property.getKeyPath(v), ascending: asc)
    }
    
}

extension [SortDesc] {
    
    private static func nameSortDesc(_ b: Bool) -> Self {
        [
            .init(keyPath: Game.rawKeyPath, ascending: b),
            .init(keyPath: Game.releaseKeyPath, ascending: true),
            .init(keyPath: Game.addKeyPath, ascending: true)
        ]
    }
    
    private static func releaseSortDesc(_ b: Bool) -> Self {
        [
            .init(keyPath: Game.releaseKeyPath, ascending: b),
            .init(keyPath: Game.rawKeyPath, ascending: true),
            .init(keyPath: Game.addKeyPath, ascending: true)
        ]
    }
    
    private static func addSortDesc(_ b: Bool) -> Self {
        [
            .init(keyPath: Game.addKeyPath, ascending: b),
            .init(keyPath: Game.rawKeyPath, ascending: true),
            .init(keyPath: Game.releaseKeyPath, ascending: true)
        ]
    }
    
    public static func gamesSortDesc(_ s: SortEnum, _ b: Bool) -> Self {
        switch s {
        case .name: return .nameSortDesc(b)
        case .release: return .releaseSortDesc(b)
        case .add: return .addSortDesc(b)
        }
    }
    
    public static func propertiesSortDesc() -> Self {
        [.init(.primary), .init(.secondary), .init(.tertiary)]
    }
    
    
    
//    public init(_ v: SortEnum, _ b: Bool) {
//        switch v {
//        case .name: self.init(Self.nameSortDesc(b))
//        case .release: self.init(Self.releaseSortDesc(b))
//        }
//    }
    
//    private static func nameSortDesc(_ b: Binding<Bool>) -> Self {
//        [
//            .init(keyPath: Game.rawKeyPath, ascending: b.wrappedValue),
//            .init(keyPath: Game.releaseKeyPath, ascending: true)
//        ]
//    }
//
//    private static func releaseSortDesc(_ b: Binding<Bool>) -> Self {
//        [
//            .init(keyPath: Game.releaseKeyPath, ascending: b.wrappedValue),
//            .init(keyPath: Game.rawKeyPath, ascending: true)
//        ]
//    }
//
//    public init(_ v: SortEnum, _ b: Binding<Bool>) {
//        switch v {
//        case .name: self.init(Self.nameSortDesc(b))
//        case .release: self.init(Self.releaseSortDesc(b))
//        }
//    }
    
}
