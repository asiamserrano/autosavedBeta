//
//  Predicate+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation
import CoreData

public typealias Predicate = NSPredicate
public typealias CompoundPredicate = NSCompoundPredicate

public enum PredicateEnum: String {
    case equal = "=="
    case begin = "BEGINSWITH"
    case contain = "CONTAINS"
}

extension CompoundPredicate {
    
    public static func queryForProperty(_ builder: any PropertyProtocol) -> Self {
        let keys: [PropertyVariable] = [.primary, .secondary, .tertiary ]
        return .init(andPredicateWithSubpredicates: keys.map { .init($0, builder.get($0), .equal) } )
    }
    
    public static func queryForGame(_ builder: GameBuilder) -> Self {
        .init(andPredicateWithSubpredicates: [
            .init(.raw, builder.title.canonicalized, .equal),
            .init(.release, builder.release, .equal)
        ] )
    }
    
    public static func andPredicate(_ arr: [Predicate]) -> Self {
        Self.init(andPredicateWithSubpredicates: arr)
    }
    
}

extension Predicate {
    
    public convenience init(_ v: String, _ string: String?, _ pred: PredicateEnum) {
        let form: String = "\(v) \(pred.rawValue)"
        if let str: String = string {
            self.init(format: "\(form) %@", str.trimmed)
        } else {
            self.init(format: "\(form) nil")
        }
    }
    
    public convenience init(_ v: GameVariable, _ dt: Date, _ pred: PredicateEnum) {
        self.init(format: "\(v.rawValue) \(pred.rawValue) %@", dt as NSDate)
    }
    
    public convenience init(_ v: GameVariable, _ string: String, _ pred: PredicateEnum) {
        self.init(v.rawValue, string, pred)
    }
    
    public convenience init(_ v: PropertyVariable, _ string: String?, _ pred: PredicateEnum) {
        self.init(v.rawValue, string, pred)
    }

    public convenience init(_ i: InputEnum, _ p: PredicateEnum) {
        self.init(.secondary, i.key, p)
    }
    
    public static func build(from: Predicate, _ canon: String) -> Predicate {
        let count: Int = canon.count
        
        var predicate: Predicate? {
            switch count {
            case 0: return nil
            case 1: return .init(.tertiary, canon, .begin)
            default: return .init(.tertiary, canon, .contain)
            }
        }
        
        if let p2: NSPredicate = predicate {
            return CompoundPredicate.andPredicate([from, p2])
        } else { return from }
    }
    
}

