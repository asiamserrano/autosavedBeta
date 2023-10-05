//
//  Filter+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 10/4/23.
//

import Foundation
import CoreData

public enum FilterEnum: IterableProtocol {
    
    public static var Properties: [Self] {
        Self.all.filter { $0 != .raw }
    }
    
    case raw, value, tertiary, secondary
    
    public var entityEnum: EntityEnum {
        self == .raw ? .game : .property
    }
    
    private var predKey: String {
        switch self {
        case .raw: return GameVariable.raw.rawValue
        case .value: return PropertyVariable.value.rawValue
        case .tertiary: return PropertyVariable.tertiary.rawValue
        case .secondary: return PropertyVariable.secondary.rawValue
        }
    }
    
    public func generate(_ pe: PredicateEnum?, _ str: String, _ old: NSPredicate?) -> NSPredicate? {
        if let predEn: PredicateEnum = pe {
            let newPred: NSPredicate = .init(predKey, str, predEn)
            if let initPred: NSPredicate = old {
                return NSCompoundPredicate(andPredicateWithSubpredicates: [initPred, newPred])
            } else { return newPred }
        } else {
            if let o: NSPredicate = old { return o }
            else { return nil }
        }
    }
    
}
