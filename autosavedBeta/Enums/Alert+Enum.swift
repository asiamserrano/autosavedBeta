//
//  Alert+Enum.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/1/23.
//

import Foundation
import SwiftUI

public enum AlertEnum: IterableProtocol {
    case addpos, addneg, editpos, editneg
    
    public var header: String {
        switch self {
        case .addpos: return "Game added"
        case .addneg: return "Failed to add"
        case .editpos: return "Game edited"
        case .editneg: return "Failed to edit"
        }
    }
    
    public var message: String {
        switch self {
        case .addpos: return "has been added to your library."
        case .addneg, .editneg: return "already exists!"
        case .editpos: return "has been successfully edited."
        }
    }
    
    public static func build(_ success: Bool, _ add: Bool) -> Self {
        switch (success, add) {
        case (true, true): return .addpos
        case (false, true): return .addneg
        case (true, false): return .editpos
        case (false, false): return .editneg
        }
    }
    
}
