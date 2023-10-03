//
//  View+Object.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation

//
//  ViewObject.swift
//  autosave
//
//  Created by Asia Serrano on 3/18/23.
//

import SwiftUI
import Foundation
import CoreData

public struct ViewObjectKey: EnvironmentKey {

    public static var defaultValue: ViewObject = .init()

}

//public protocol ViewObjectProtocol {
//    
//    var uuid: UUID { get set }
//    var entityEnum: EntityEnum { get set }
//    var sortEnum: SortEnum { get set }
//    var ascending: Bool { get set }
//    
//}

public class ViewObject: ObservableObject, IdentifiableProtocol {
    
    @Published public var uuid: UUID = .init()
    
    @Published public var entityEnum: EntityEnum = .game
//        @Published var menuEnum: MenuEnum = .library
//        @Published var viewEnum: ViewEnum = .list
        @Published public var sortEnum: SortEnum = .name
    
    @Published public var ascending: Bool = true
    //    @Published var isDisabled: Bool = false
    //    @Published var showAlert: Bool = false
    
    //    @Published var valueEnum: PVE? = nil
    //    @Published var wishlistDevice: Device? = nil
        
//    public var sortDescs: [SortDesc] {
//        switch self.entityEnum {
//        case .game: return [SortDesc](self.sortEnum, Binding(get: { self.ascending }, set: { self.ascending = $0 }))
//        case .property: return [.init(.primary), .init(.secondary), .init(.tertiary)]
//        }
//    }
    
//    public var id: String {
//        let enums: [any EnumProtocol] = [deviceEnum, viewEnum, sortEnum, statusEnum]
//        return (enums.map { $0.id } + [self.ascending.description]).hashed
//    }
    
//    public var status: Bool? {
//        self.menuEnum.status
//    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.entityEnum)
//        hasher.combine(self.viewEnum)
        hasher.combine(self.sortEnum)
//        hasher.combine(self.status)
        hasher.combine(self.ascending)
    }
    
    public func nextSortEnum() -> Void {
        self.sortEnum = self.sortEnum.iterateToNext()
    }
    
    public func toggleDirection(_ new: Bool? = nil) -> Void {
        self.ascending = new ?? !self.ascending
    }
    
    public func updateID() -> Void {
        self.uuid = .init()
    }
    
}

//public extension ViewObject {
//
//    var createAlert: Alert {
//        self.alertObject.createAlert
//    }
//
//    var filterIcon: String {
//        "line.3.horizontal.decrease.circle\(self.valueEnum == nil ? .empty : ".fill")"
//    }
//
//    var statusEnum: StatusEnum {
//        self.menuEnum.statusEnum
//    }
//
////    var menuEnum: MenuEnum {
////        self.statusEnum.menuEnum
////    }
//
//    var sortBinding: Binding<SortEnum> {
//        Binding<SortEnum>(
//            get: { self.sortEnum },
//            set: {
//                if self.sortEnum == $0 {
//                    self.ascending.toggle()
//                } else {
//                    self.ascending = true
//                    self.sortEnum = $0
//                }
//            }
//        )
//    }
//
////    var statusBinding: Binding<StatusEnum> {
////        Binding<StatusEnum>(
////            get: { self.statusEnum },
////            set: { _ in }
////        )
////    }
//
//    var menuBinding: Binding<MenuEnum> {
//        Binding<MenuEnum>(
//            get: {  self.menuEnum },
//            set: { self.menuEnum = $0 }
//        )
//    }
//
//    var deviceBinding: Binding<DeviceEnum> {
//        Binding<DeviceEnum>(
//            get: {  self.deviceEnum },
//            set: { self.deviceEnum = $0 }
//        )
//    }
//
//}
//
//public extension ViewObject {
//
//    func getSortIcon(_ item: SortEnum) -> String? {
//        item == self.sortEnum ? "chevron.\(self.ascending ? "up" : "down")" : nil
//    }
//
//    func deleteDevice(_ del: Device, _ moc: MOC) -> Void {
//        let t: String = "Confirm delete \(self.deviceEnum.id)"
//        let m: String = "Are you sure you want to delete \(del.shorthand)?"
//        let action: () -> Void = { moc.removeDevice(del) }
//        let p: Alert.Button = .destructive("Yes", action)
//        let s: Alert.Button = .cancel("No")
//
//        self.menuEnum == .wishlist ? action() : self.toggleAlert(t, m, p, s)
//    }
//
//    func moveDevice(_ dev: Device, _ moc: MOC) -> Void {
//        switch dev.statusEnum {
//        case .owned:
//            let action: () -> Void = {
//                let builder: Device.Builder = .changeStatus(dev)
//                moc.build(builder, dev)
//                self.menuEnum = builder.statusEnum.menuEnum
//            }
//            let primary: Alert.Button = .default("Yes", action)
//            let a: String = "Confirm move to wishlist"
//            let b: String = "Are you sure you want to move \(dev.shorthand) to your wishlist?"
//            self.toggleAlert(a, b, primary, .cancel("No"))
//
//        case .unowned: self.wishlistDevice = dev
//        case .none: return
//        }
//    }
//
//    func saveDevice(_ obs: Device.Observable, _ moc: MOC) -> Void {
//        let obsBuilder: Device.Builder = .init(obs)
//        let obsDevice: Device? = obs.device
//
//        let done: Alert.Button = .cancel("Okay")
//
//        if let found: Device =  moc.getByBuilder(obsBuilder) {
//            if found != obsDevice {
//
//                let title: String = "Duplicate \(found.deviceEnum.id)"
//                let A: MenuEnum = found.statusEnum.menuEnum
//                let equalBool: Bool = found.statusEnum == obs.statusEnum
//                let libraryBool: Bool = A == .library
//                let location: String = "\(libraryBool ? "in" : "on") your \(A.id)"
//                let message: String = "\(found.shorthand) is already \(location)!"
//
//                if obsDevice == nil && !equalBool {
//                    let B: MenuEnum = libraryBool ? .wishlist : .library
//                    let primary: Alert.Button = .default("Yes", { moc.build(.changeStatus(found), found) })
//                    let b: String = "\(message) Do you want to move it to your \(B.id)?"
//                    return self.toggleAlert(title, b, primary, .cancel("No"))
//                } else {  return self.toggleAlert(title, message, done) }
//            }
//        }
//
//        self.valueEnum = nil
//
//        let new: Device = moc.build(obsBuilder, obsDevice)
//        let isNew: Bool = obsDevice == nil
//        let title: String = "\(new.deviceEnum.display) \(isNew ? "created" : "updated")"
//        let location: MenuEnum = new.statusEnum.menuEnum
//        return self.toggleAlert(title, "\(new.shorthand) has been sucessfully \(isNew ? "added to your \(location.id)" : "edited")!", done)
//    }
//
//    func deleteLibraries(_ set: Set<GroupEnum>, _ moc: MOC) -> Void {
//
//        let message: String = "Are you sure you want to delete all \(GroupEnum.setDisplay(set)) data? This action cannot be reversed."
//
//        let primary: Alert.Button = .destructive("Confirm") {
//            set.forEach { item in
//                item.builder.createData(moc).forEach { device in
//                    moc.removeDevice(device as! Device)
//                }
//            }
//        }
//
//        self.toggleAlert("Delete library", message,primary, .cancel("Cancel"))
//    }
//
//    func deleteProperty(_ s: PropertiesView.Builder, _ moc: MOC) -> Void {
//        let display: String = "\(s.pte.id)\(s.isFormat ? "format" : " ")property"
//        let message: String = "Are you sure you want to delete \(display) \(s.display)?"
//        let primary: Alert.Button = .destructive("Yes") { s.properties.forEach{ moc.removeProperty($0) } }
//
//        self.toggleAlert("Delete property", message, primary, .cancel("No"))
//    }
//
//    func filterProperty(_ s: PropertiesView.Builder) -> Void {
//        self.valueEnum = s.pve
//        self.deviceEnum = s.device
//        self.menuEnum = .library
//    }
//
//    func editProperty(_ s: PropertiesView.Builder, _ str: String, _ moc: MOC) -> Void {
//        let pte: PTE = s.pte
//        let bool: Bool = s.contains(str)
//        let title: String = bool ? "Duplicate property" : "Property updated"
//        let msg1: String = "\(pte.display) \(str)"
//
//        var msg2: String {
//            if bool {
//                return "already exists!"
//            } else {
//                s.properties.forEach { property in
//                    property.property_value = str
//                    moc.saveChanges()
//                }
//                return "has been edited successfully!"
//            }
//        }
//
//        self.toggleAlert(title, "\(msg1) \(msg2)", .cancel("Okay"))
//    }
//
//    func toggleAlert(_ t: String, _ m: String, _ p: Alert.Button, _ s: Alert.Button? = nil) -> Void {
//        self.alertObject = .init(t, m, p, s)
//        self.showAlert.toggle()
//    }
//
//}
