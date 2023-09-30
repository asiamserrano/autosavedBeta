//
//  SortDesc+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation
import CoreData

public typealias SortDesc = NSSortDescriptor

extension SortDesc {
    
    public convenience init(_ v: VariableEnum, _ asc: Bool = true) {
        self.init(keyPath: Property.getKeyPath(v), ascending: asc)
    }
    
}
