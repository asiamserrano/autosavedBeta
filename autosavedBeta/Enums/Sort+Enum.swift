//
//  Sort+Enum.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation


public enum SortEnum: IterableProtocol {
    
    public static func filterForStatus(_ status: Bool) -> [Self] {
        Self.all.filter { $0 == .add ? !status : true }
    }
    
    case name, release, add
    
    public var value: String {
        switch self {
        case .release: return "Release Date"
        case .add: return "Add Date"
        case .name: return self.defaultValue
        }
    }
    
}
