//
//  Type+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum TypeEnum: IterableProtocol {
    
    case platform, input, mode
    
    public func equals(_ other: any PropertyProtocol) -> Bool {
        self == other.typeEnum
    }
    
}
