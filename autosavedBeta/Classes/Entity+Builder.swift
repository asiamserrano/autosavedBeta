////
////  Entity+Builder.swift
////  autosavedBeta
////
////  Created by Asia Michelle Serrano on 10/2/23.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//public typealias EntityBuilder = EntityListBuilder<ManObj>
//
//public class EntityListBuilder<T: ManObj>: ObservableObject {
//    
//    typealias PropertyAction = (String) -> Void
//
////    let predicate: Predicate
////    let sortDescriptors: [SortDesc]
//    let viewObject: ViewObject?
//    let entityEnum: EntityEnum
////    let propertyAction: PropertyAction?
//    
//    init( _ e: EntityEnum, _ vo: ViewObject? = nil) {
//        self.viewObject = vo
//        self.entityEnum = e
//    }
//    
////    init(_ e: EntityEnum, _ status: Bool) {
////        self.sortDescriptors = .init(.name)
////        self.predicate = Self.createDevicePredicate(d, s)
////        self.entityEnum = .device
////        self.viewObject = nil
////        self.propertyAction = nil
////    }
////
////    init(_ v: ViewObject) {
////        self.sortDescriptors = v.sortEnum.sortCases(v.ascending)
////        self.predicate = Self.createDevicePredicate(v.deviceEnum, v.statusEnum, v.valueEnum)
////        self.entityEnum = .device
////        self.viewObject = v
////        self.propertyAction = nil
////    }
////
////    init(_ d: DeviceEnum, _ key: PTE, _ action: PropertyAction? = nil) {
////        self.sortDescriptors = Property.sortDescriptors
////        self.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
////            NSPredicate(format: "property_device == %@", d.id),
////            Property.createTypePredicate(key)
////        ])
////        self.entityEnum = .property
////        self.viewObject = nil
////        self.propertyAction = action
////    }
//    
////    init(_ key: PTE) {
////        self.sortDescriptors = Property.sortDescriptors
////        self.predicate = Property.createTypePredicate(key)
////        self.entityEnum = .property
////        self.viewObject = nil
////        self.propertyAction = nil
////    }
//    
////    func createString(_ item: T) -> String {
////        switch self.entityEnum {
////        case .device: return Device.searchFunction(item as! Device)
////        case .property: return Property.searchFunction(item as! Property)
////        case .identifier: return Identifier.searchFunction(item as! Identifier)
////        }
////    }
//    
//    func createData(_ con: Context) -> [T] {
////        con.fetchEntities(self.entityEnum) as! [T]
//    }
//    
////    private static func createDevicePredicate(_ d: DeviceEnum, _ s: StatusEnum, _ val: PVE? = nil) -> NSPredicate {
////        if let v: PVE = val {
////            return NSPredicate(format: "ANY device_bucket.property_value == %@", v.id)
////        } else {
////            return NSCompoundPredicate(andPredicateWithSubpredicates: [
////                NSPredicate(format: "identifier_type == %@", d.id),
////                NSPredicate(format: "device_status == %@", s.id)
////            ])
////        }
////    }
//    
//}
