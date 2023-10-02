//
//  Entity+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation
import CoreData
import SwiftUI

public protocol EntityProtocol: IdentifiableProtocol, NSManagedObject {
    
//    static func transform(_ nsset: NSSet) -> [Self]
//    static func transform(_ array: [Self]) -> NSSet
    
    static var entityEnum: EntityEnum { get }
    
    var InListView: any View { get }
}

extension EntityProtocol {
    
//    public static func transform(_ nsset: NSSet) -> [Self] {
//        nsset.filter { $0 is Self }.map { $0 as! Self }
//    }
//    
//    public static func transform(_ array: [Self]) -> NSSet {
//        .init(array: array)
//    }
    
}
