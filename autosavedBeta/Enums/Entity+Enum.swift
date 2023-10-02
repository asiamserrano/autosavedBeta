//
//  Entity+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum EntityEnum: IterableProtocol {
    case game, property
    
    public var plural: String {
        switch self {
        case .game: return "Games"
        case .property: return "Properties"
        }
    }
    
}
