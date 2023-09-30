//
//  Context+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import CoreData
import SwiftUI

public typealias Context = NSManagedObjectContext

extension Context {
    
    @discardableResult
    public func store() -> Bool {
        do {
            try self.save()
            return true
        } catch {
            self.rollback()
            return false
        }
    }
    
        @discardableResult
        private func fetchProperties(_ p: Predicate, _ s: [SortDesc]? = nil) -> [Property] {
            let fetchRequest: NSFetchRequest<Property> = Property.fetchRequest()
            fetchRequest.predicate = p
            fetchRequest.sortDescriptors = s
            return (try? self.fetch(fetchRequest)) ?? .init()
        }
    
        @discardableResult
        func fetchProperty(_ builder: any BuilderProtocol) -> Property {
            let predicate: CompoundPredicate = .queryForProperty(builder)
            if let property: Property = self.fetchProperties(predicate).first {
                return property
            } else {
                let property: Property = .init(context: self).set(builder)
                self.store()
                return property
            }
    
        }
    
        @discardableResult
        func fetchProperties(_ i: InputEnum, _ str: Binding<String>) -> [Property] {
            let canon: String = str.wrappedValue.canonicalized
            let p1: Predicate = .init(i, .equal)
            let predicate: Predicate = .build(from: p1, canon)
            return self.fetchProperties(predicate, [.init(.value)])
        }
    
}
