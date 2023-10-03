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
    
}

public extension StandardViewProtocol {
    
    var uuid: UUID { self.viewObject.uuid }
    var hashValue: Int { self.viewObject.hashValue }
    var entityEnum: EntityEnum { self.viewObject.entityEnum }
    var sortEnum: SortEnum { self.viewObject.sortEnum }
    var menuEnum: MenuEnum { self.viewObject.menuEnum }
    var ascending: Bool { self.viewObject.ascending }
    
    var sortBinding: Binding<SortEnum> {
        Binding<SortEnum>(
            get: { self.sortEnum },
            set: { self.viewObject.toggleDirection($0) }
        )
    }
    
    func getSortIcon(_ item: SortEnum) -> String? {
        item == self.sortEnum ? "arrow.\(self.ascending ? "up" : "down")" : nil
    }
    
    func nextSortEnum() -> Void {
        self.viewObject.nextSortEnum()
    }
    
    func reset(_: MenuEnum) -> Void {
        self.viewObject.reset()
    }
    
//    func toggleDirection() -> Void {
//        self.viewObject.toggleDirection()
//    }
    
//    func setDirection(_ s: SortEnum) -> Void {
//        self.viewObject.toggleDirection(s)
//    }
//
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
