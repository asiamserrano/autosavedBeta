//
//  Input+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum InputEnum: IterableProtocol {
    
    public static func filterForEditing(_ bool: Bool) -> [Self] {
        Self.all.filter { $0 == .series ? bool : true }
    }
    
    case series, developer, publisher, genre
    
    public var isSingular: Bool {
        self == .series
    }
    
}
