//
//  Search+Object.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/5/23.
//

import SwiftUI
import Foundation
import CoreData

public class SearchObject: ObservableObject {
    
    @Published public var input: String = .empty
    
    public var canon: String {
        self.input.canonicalized
    }
    
    public var predicateEnum: PredicateEnum? {
        switch canon.count {
        case 0: return nil
        case 1: return .begin
        default: return .contain
        }
    }
    
    public func predicate(_ keyPath: GameVariable, _ old: NSPredicate?) -> NSPredicate? {
        predicate(keyPath.rawValue, old)
    }
    
    public func predicate(_ keyPath: PropertyVariable, _ old: NSPredicate?) -> NSPredicate? {
        predicate(keyPath.rawValue, old)
    }
    
    private func predicate(_ keyPath: String, _ old: NSPredicate?) -> NSPredicate? {
        if let oldPred: NSPredicate = old {
            if let predEn: PredicateEnum = self.predicateEnum {
                let preds: [NSPredicate] = [oldPred, .init(keyPath, self.canon, predEn)]
                return NSCompoundPredicate(andPredicateWithSubpredicates: preds)
            } else { return oldPred }
        } else { return nil }
    }
    
}
