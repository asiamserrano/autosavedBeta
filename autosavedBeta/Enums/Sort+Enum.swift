//
//  Sort+Enum.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation


public enum SortEnum: IterableProtocol {
    
    public static func filterForStatus(_ status: Bool) -> [Self] {
        Self.all.filter { $0 == .add ? !status : true }
    }
    
    case name, release, add
    
    public var value: String {
        switch self {
        case .release: return "Release Date"
        case .add: return "Add Date"
        case .name: return self.defaultValue
        }
    }
    
//
//    public func sortCases(_ asc: Bool) -> [NSSortDescriptor] {
//        var cases: [Self] {
//            switch self {
//            case .name: return [.name, .release, .add]
//            case .release: return [.release, .name, .add]
//            case .add: return [.add, .name, .release]
//            }
//        }
//
//        return cases.map { NSSortDescriptor(key: "device_\($0.id)", ascending: asc) }
//    }
    
}
