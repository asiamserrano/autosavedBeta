//
//  Platform+Builder.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Platform.Builder: Iterable {

    public static var cases: Cases {
        System.Builder.cases.flatMap(\.platformBuilders)
    }
    
}

extension Platform.Builder {
    
//    public init(model: Model) {
//        if let s = model.system?.builder.asEnumerable(SystemBuilder.self),
//           let f = model.format?.builder.asEnumerable(FormatBuilder.self) {
//            self = .init(system: s, format: f)
//        } else {
//            fatalError("Unable to cast model to platform builder")
//        }
//    }
//    
//    public var compoundKey: Compound.Key {
//        .init(key: self.system.id, value: self.format.id)
//    }
//    
//    public var rawValue: String {
//        "\(self.system.rawValue) | \(self.format.rawValue)"
//    }
//    
//    public var modelBuilder: Generic.Model.Builder {
//        .platform(self)
//    }
//    
//    public var attributeBuilder: Generic.Attribute.Builder { .platform(self) }
    
}
