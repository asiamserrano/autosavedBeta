//
//  Mode.swift
//  autosave
//
//  Created by Asia Serrano on 5/9/25.
//

import Foundation
import Core

public struct Mode {
    
    public enum Enum: Enumerable {
        
        case single, two, multi
        
        public var rawValue: String {
            switch self {
            case .single: return "Single-Player"
            case .two: return "Two-Player"
            case .multi: return "Multiplayer"
            }
        }
        
    }
    
}

extension Mode.Enum {

    public var icon: Icon.Enum {
        switch self {
        case .single: return .person_fill
        case .two: return .person_2_fill
        case .multi: return .person_3_fill
        }
    }
    
}
