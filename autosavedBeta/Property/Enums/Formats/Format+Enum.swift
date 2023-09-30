//
//  Format+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum FormatEnum: IterableProtocol {
    
    public static var allCases: [Self] {
        [
            DigitalEnum.all.map(FormatEnum.digital),
            PhysicalEnum.all.map(FormatEnum.physical)
        ].flatMap { $0 }
    }
    
    public enum DefaultEnum: IterableProtocol {
        case digital, physical
                
        public var icon: String {
            switch self {
            case .digital: return "arrow.down.circle.fill"
            case .physical: return "opticaldisc.fill"
            }
        }
    }
    
    case digital(DigitalEnum)
    case physical(PhysicalEnum)
    
}

extension FormatEnum {
    
    private var child: any FormatProtocol {
        switch self {
        case .digital(let d): return d
        case .physical(let p): return p
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.className)
        hasher.combine(self.child.className)
        hasher.combine(self.child.key)
    }
    
    public var key: String {
        self.child.key
    }
    
    public var value: String {
        self.child.value
    }
    
    public var icon: String {
        self.child.icon
    }
    
}
