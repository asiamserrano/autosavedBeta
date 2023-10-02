//
//  View+Enum.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation

public enum ViewEnum: IterableProtocol {
    case list, icons
    
    var icon: String {
        switch self {
        case .list:
            return "list.bullet"
        case .icons:
            return "square.grid.2x2"
        }
    }
    
}
