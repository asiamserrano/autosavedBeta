//
//  Mode+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum ModeEnum: IterableProtocol {
    
    case single, two, multi
    
    public var value: String {
         switch self {
         case .single: return "Single-Player"
         case .two: return "Two-Player"
         case .multi: return "Multiplayer"
         }
     }
}
