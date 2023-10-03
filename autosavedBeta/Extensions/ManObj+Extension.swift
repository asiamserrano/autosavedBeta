//
//  ManObj+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation
import CoreData

public typealias ManObj = NSManagedObject

extension ManObj {
    
    public class ObjectTuple: NSObject {
        let header: String
        let message: String?

        public override init() {
            self.header = .empty
            self.message = nil
        }
        
        public init(_ h: String, _ m: String?) {
            self.header = h
            self.message = m
        }
    }

    
    @objc public var string: String { .empty }
    
    @objc public var tuple: ObjectTuple { .init() }
    
    @nonobjc public class func fetchRequest(_ e: EntityEnum) -> NSFetchRequest<ManObj> {
        return NSFetchRequest<ManObj>(entityName: e.value)
    }

}
