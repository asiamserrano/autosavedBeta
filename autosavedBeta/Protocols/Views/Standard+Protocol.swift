//
//  Standard+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation
import CoreData
import SwiftUI

public protocol StandardViewProtocol: View {
    
    var viewObject: ViewObject { get }
    var viewContext: Context { get }
    
}

public extension StandardViewProtocol {
    
    var hashValue: Int { self.viewObject.hashValue }
    var entityEnum: EntityEnum { self.viewObject.entityEnum }
    var sortEnum: SortEnum { self.viewObject.sortEnum }
    var ascending: Bool { self.viewObject.ascending }
    
    func nextSortEnum() -> Void {
        self.viewObject.nextSortEnum()
    }
    
    func toggleDirection() -> Void {
        self.viewObject.toggleDirection()
    }
    
    func setDirection(_: SortEnum) -> Void {
        self.viewObject.toggleDirection(true)
    }
    
    func updateID(_: Int) -> Void {
        self.viewObject.updateID()
    }
    
//    func deleteAction(_ entity: Entity) -> Void {
//        self.viewObject.deleteDevice(device, self.viewContext)
//    }
//
//    func fetchData(_ builder: FilteredListBuilder) -> [NSManagedObject] {
//        builder.createData(self.viewContext)
//    }
    
}
