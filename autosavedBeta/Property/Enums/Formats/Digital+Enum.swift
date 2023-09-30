//
//  Digital+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum DigitalEnum: FormatProtocol {
    
    public static var defaultFormat: DefaultFormat  { .digital }
    
    case steam, origin, psn, xbox, nintendo, file
    
    public var value: String {
        switch self {
        case .psn: return "Playstation Network"
        case .xbox: return "Xbox Live"
        case .nintendo: return "Nintendo eShop"
        case .file: return "System File"
        default: return self.defaultValue
        }
    }
    
}
