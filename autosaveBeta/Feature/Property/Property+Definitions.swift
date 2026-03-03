//
//  Property+Definitions.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Property {
        
    public enum Enum: Enumerable.Enum.Interface {
        case input, mode, system, format
        
        public enum Builder: Enumerable.Enum.Builder.Interface {
            case input(Input.Enum)
            case mode
            case system(System.Enum)
            case format(Format.Enum)
        }
        
    }
    
    public enum Builder: ModelKit.Model.Builder.Interface {
        case input(Input.Builder)
        case mode(Mode.Enum)
        case system(System.Builder)
        case format(Format.Builder)
        
        public var attribute: Attribute.Builder? {
            switch self {
            case .input(let i): return .input(i)
            case .mode(let m): return .mode(m)
            default: return nil
            }
        }
        
    }
    
}
