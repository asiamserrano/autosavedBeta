//
//  Input+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public struct InputBuilder: BuilderProtocol {
    
    public static var typeEnum: TypeEnum { .input }

    var inputEnum: InputEnum
    var value: String
    
    public init(_ i: InputEnum, _ s: String) {
        self.inputEnum = i
        self.value = s
    }
    
    public init(_ any: any PropertyProtocol) {
        self.inputEnum = .init(any.get(.secondary))!
        self.value = any.get(.value)!
    }
    
    public func get(_ v: VariableEnum) -> String? {
        switch v {
        case .primary: return self.typeEnum.key
        case .secondary: return self.inputEnum.key
        case .tertiary: return self.value.canonicalized
        case .value: return self.value.trimmed
        }
    }
   
}
