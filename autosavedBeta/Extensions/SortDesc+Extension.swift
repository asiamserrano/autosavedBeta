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
    
    private static func nameSortDesc(_ b: Binding<Bool>) -> Self {
        [
            .init(keyPath: Game.rawKeyPath, ascending: b.wrappedValue),
            .init(keyPath: Game.releaseKeyPath, ascending: true)
        ]
    }
    
    private static func releaseSortDesc(_ b: Binding<Bool>) -> Self {
        [
            .init(keyPath: Game.releaseKeyPath, ascending: b.wrappedValue),
            .init(keyPath: Game.rawKeyPath, ascending: true)
        ]
    }
    
    public init(_ v: SortEnum, _ b: Binding<Bool>) {
        switch v {
        case .name: self.init(Self.nameSortDesc(b))
        case .release: self.init(Self.releaseSortDesc(b))
        }
    }
    
}
