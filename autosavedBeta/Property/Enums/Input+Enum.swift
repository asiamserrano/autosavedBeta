//
//  Input+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum InputEnum: IterableProtocol {
    
    case series, developer, publisher, genre
    
    public var isSingular: Bool {
        self == .series
    }
    
}
