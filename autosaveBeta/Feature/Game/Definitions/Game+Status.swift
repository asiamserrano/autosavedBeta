//
//  Game+Status.swift
//  AutoSaveMock
//
//  Created by Asia Serrano on 2/6/26.
//

import Foundation
import Core

extension Game.Status {
    
    public init(_ bool: Bool) {
        switch bool {
        case true: self = .library
        case false: self = .wishlist
        }
    }
    
    public var bool: Bool {
        switch self {
        case .library: return true
        case .wishlist: return false
        }
    }
    
    public var icon: Icon.Enum {
        switch self {
        case .wishlist: return .list_star
        case .library: return .gamecontroller
        }
    }
    
}
