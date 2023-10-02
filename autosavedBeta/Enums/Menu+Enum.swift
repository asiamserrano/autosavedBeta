//
//  Menu+Enum.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation


public enum MenuEnum: IterableProtocol {
    case library, wishlist, properties, statistics
    
    var icon: String {
        switch self {
        case .library:
            return "list.bullet.below.rectangle"
        case .wishlist:
            return "list.star"
        case .properties:
            return "list.bullet.indent"
        case .statistics:
            return "chart.xyaxis.line"
        }
    }
    
    var status: Bool? {
        switch self {
        case .library: return true
        case .wishlist: return false
        default: return nil
        }
    }
    
}
