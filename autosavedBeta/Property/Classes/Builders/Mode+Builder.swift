//
//  Mode+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public struct ModeBuilder: BuilderProtocol {
    
    public static var typeEnum: TypeEnum { .mode }

    var modeEnum: ModeEnum
    
    public init(_ m: ModeEnum) {
        self.modeEnum = m
    }
    
    public init(_ any: any PropertyProtocol) {
        self.modeEnum = .init(any.get(.secondary))!
    }
    
    public func get(_ v: VariableEnum) -> String? {
        switch v {
        case .primary: return self.typeEnum.key
        case .secondary: return self.modeEnum.key
        default: return nil
        }
    }

}
