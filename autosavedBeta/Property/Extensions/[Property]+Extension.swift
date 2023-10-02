//
//  [Property]+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

public extension Array where Element == Property {
    
    var toBuilders: [PropertyBuilder] {
        self.map { $0.builder }
    }
    
    func contains(_ v: PropertyVariable, _ str: String) -> Bool {
        self.contains(where: { $0.get(v) == str })
    }

}
