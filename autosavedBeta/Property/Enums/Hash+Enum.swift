//
//  Hash+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum HashEnum: IterableProtocol {
    
    case key, value
    
    public func toggle() -> Self {
        self == .key ? .value : .key
    }
    
}
