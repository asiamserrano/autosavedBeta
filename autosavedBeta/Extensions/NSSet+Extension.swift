//
//  NSSet+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

extension NSSet {
    
    public convenience init(_ arr: [any PropertyProtocol]) {
        self.init(array: arr)
    }
    
//    public static func buildForBuilders(_ arr: [PropertyBuilder]) -> Self {
//        .init(array: arr)
//    }
    
//    public static func buildForProperties(_ arr: [Property]) -> Self {
//        .init(array: arr)
//    }
    
}
