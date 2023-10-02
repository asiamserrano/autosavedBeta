//
//  Input+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public struct InputBuilder: BuilderProtocol {
    
    public static var typeEnum: TypeEnum { .input }
    
    public static var random: Self {
        let input: InputEnum = .random
        let string: String = .random
        return .init(input, "\(input.value) \(string)")
    }

    var inputEnum: InputEnum
    var value: String
    
    public init(_ i: InputEnum, _ s: String) {
        self.inputEnum = i
        self.value = s.trimmed
    }
    
    public init(_ any: any PropertyProtocol) {
        self.inputEnum = .init(any.get(.secondary))!
        self.value = any.get(.value)!
    }
    
    public func get(_ v: PropertyVariable) -> String? {
        switch v {
        case .primary: return self.typeEnum.key
        case .secondary: return self.inputEnum.key
        case .tertiary: return self.value.canonicalized
        case .value: return self.value.trimmed
        }
    }
   
    public var tuple: (String, String) {
        (self.value.canonicalized, self.value)
    }
    
    public var display: String {
        "\(self.inputEnum.value) | \(self.value)"
    }
    
}
