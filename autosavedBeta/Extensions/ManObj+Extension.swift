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
    
    @objc public var string: String { .empty }
    
    @nonobjc public class func fetchRequest(_ e: EntityEnum) -> NSFetchRequest<ManObj> {
        return NSFetchRequest<ManObj>(entityName: e.value)
    }

}
