//
//  Platform+Definitions.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Platform {

    public struct Builder: ModelKit.Model.Builder.Interface {
                
        public typealias Model = Platform

        public let system: System.Builder
        public let format: Format.Builder
        
        public init(system: System.Builder, format: Format.Builder) {
            if system.formatBuilders.contains(format) {
                self.system = system
                self.format = format
            } else {
                fatalError("Unable to cast system '\(system.rawValue)' and format '\(format.rawValue)' to platform builder")
            }
        }
        
    }
    
}

extension Platform.Builder: ProtocolKit.Random.Compound.Interface {
    
    public static var random: Self {
        let s: System.Builder = .random
        return .init(system: s, format: s.formatBuilders.random)
    }
    
    public var compound: Compound {
        .init(first: self.system, last: self.format)
//        .init(storage: [
//            0: self.system.id,
//            1: self.format.id
//        ])
    }
    
//    public var id: String {
//        let array = [self.system.id, self.format.id]
//        return array.joined(separator: " | ")
//    }
    
}
