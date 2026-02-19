//
//  Game+Public.swift
//  AutoSaveMock
//
//  Created by Asia Serrano on 2/6/26.
//

import Foundation
import Core

public extension Game {
    
//    func insert(_ attribute: Generic.Attribute.Model?) -> Void {
//        if let attribute = attribute {
//            switch attribute {
//            case .property(let property): self.properties.append(property)
//            case .platform(let platform): self.platforms.append(platform)
//            }
//        }
//    }
    
}

extension Game.Object.Interface {
    
    public typealias Compound = Compoundable.Interface.Compound
    
    public var compoundForSwiftData: Compound {
        .init(first: self.title.canonicalized, last: self.release.dashless)
//        .init(storage: [
//            0: self.title.canonicalized,
//            1: self.release.dashless
//        ])
    }
    
//    public var idForSwiftData: String {
//        let array = [self.title.canonicalized, self.release.dashless]
//        return array.joined(separator: " | ")
//    }
    
}
