//
//  Platform+Builder.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public struct PlatformBuilder: BuilderProtocol {
    
    public static var typeEnum: TypeEnum { .platform }

    var platformEnum: PlatformEnum
    var formatEnum: FormatEnum
    
    public init(_ p: PlatformEnum, _ f: FormatEnum) {
        self.platformEnum = p
        self.formatEnum = f
    }
    
    public init(_ any: any PropertyProtocol) {
        self.platformEnum = .init(any.get(.secondary))!
        self.formatEnum = .init(any.get(.tertiary))!
    }
        
    public func get(_ v: VariableEnum) -> String? {
        switch v {
        case .primary: return self.typeEnum.key
        case .secondary: return self.platformEnum.key
        case .tertiary: return self.formatEnum.key
        case .value: return nil
        }
    }
    
    public var tuple: (PlatformEnum, FormatEnum) {
        (self.platformEnum, self.formatEnum)
    }
    
}
