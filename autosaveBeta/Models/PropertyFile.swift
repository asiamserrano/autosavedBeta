//
//  PropertyFile.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/23/26.
//

import Foundation
import Core
import SwiftData
import Combine

@Model
public final class Property: UUIDPersistentModel {
    
    public static func insertPredicate(_ uuid: UUID) -> Predicate<Property> {
        #Predicate<Property> { $0.uuid == uuid }
    }
    
    public static func mode(_ m: Mode.Enum) -> Property {
        .init(m, identifier: .mode, registry: .mode, association: .game)
    }
    
    public static func format(_ f: Format.Registry) -> Property {
        .init(f, identifier: .format, registry: .format(f.identifier), association: .platform)
    }
    
    public static func system(_ s: System.Registry) -> Property {
        .init(s, identifier: .system, registry: .system(s.identifier), association: .platform)
    }
    
//    public static func input(_ i: Input.Builder) -> Property {
//        let ns: UUIDNamespace = .input
//        
//        
//        
//        
////        .init(s, type: .system(s.type), superType: .system, association: .platform)
//    }
   
//    public private(set) var uuid: UUID
//    public private(set) var type_class_id: String // ex: Grand Theft Auto
//    public private(set) var super_type_class_id: String // ex: Series
//    public private(set) var association_id: String // ex: Game
//    public private(set) var content_id: String // ex: Grand Theft Auto
//    public private(set) var content_rawValue: String // ex: Grand Theft Auto
    
    public private(set) var uuid: UUID
    public private(set) var identifier_id: String // ex: Grand Theft Auto
    public private(set) var registry_id: String // ex: Series
    public private(set) var association_id: String // ex: Game
    public private(set) var content_id: String // ex: Grand Theft Auto
    public private(set) var content_rawValue: String // ex: Grand Theft Auto
    
    private init(uuid: UUID, content_id: String, content_rawValue: String, _ identifier: Identifier, _ registry: Registry, _ association: Association) {
        self.uuid = uuid
        self.identifier_id = identifier.id
        self.registry_id = registry.id
        self.association_id = association.id
        self.content_id = content_id
        self.content_rawValue = content_rawValue
    }
    
    private convenience init<T: Enumerable>(_ t: T, identifier: Identifier, registry: Registry, association: Association) {
        self.init(uuid: t.uuid, content_id: t.id, content_rawValue: t.rawValue, identifier, registry, association)
    }
    
    
//    private init(content_id: String, content_rawValue: String, type: TypeClass, superType: SuperTypeClass, association: Association) {
//        self.uuid = .v3
//        self.type_class_id = type.id
//        self.super_type_class_id = superType.id
//        self.association_id = association.id
//        self.content_id = t.id
//        self.content_rawValue = t.rawValue
//    }
//    
//    private init<T: Enumerable>(_ t: T, type: TypeClass, superType: SuperTypeClass, association: Association) {
//        self.uuid = .v3(enumerable: t, for: Self.self)
//        self.type_class_id = type.id
//        self.super_type_class_id = superType.id
//        self.association_id = association.id
//        self.content_id = t.id
//        self.content_rawValue = t.rawValue
//    }
    
//    private init() {
//        self.uuid = .defaultValue
//        self.type_id = .defaultValue
//        self.value = .defaultValue
//        self.association_id = .defaultValue
//    }
    
    public enum Association: Enumerable {
        case game, platform
    }
    
    public enum Identifier: EnumerableRegistryIdentifier {
        case input, mode, system, format
        
        public var registryMembers: Registry.Members {
            switch self {
            case .input: return Input.Identifier.cases.map(Registry.input)
            case .mode: return [ .mode ]
            case .system: return System.Identifier.cases.map(Registry.system)
            case .format: return Format.Identifier.cases.map(Registry.format)
            }
        }
        
    }
    
    public enum Registry: EnumerableRegistry {

        case input(Input.Identifier)
        case mode
        case system(System.Identifier)
        case format(Format.Identifier)
        
        public var identifier: Identifier {
            switch self {
            case .input: return .input
            case .mode: return .mode
            case .system: return .system
            case .format: return .format
            }
        }
        
//        public var anyMember: AnyMember {
//            switch self {
//            case .input(let i): return i
//            case .mode: return identifier
//            case .system(let s): return s
//            case .format(let f): return f
//            }
//        }
        
        public var rawValue: String {
            switch self {
            case .input(let i): return i.rawValue
            case .mode: return identifier.rawValue
            case .system(let s): return s.rawValue
            case .format(let f): return f.rawValue
            }
        }
        
    }
    
}

extension Property {
    
//    public var rawValue: String { self.content_rawValue }
//  
//    public var association: Association {
//        .init(self.association_id)
//    }
//    
//    public var typeClass: TypeClass {
//        .init(self.type_class_id)
//    }
//    
//    public var superTypeClass: SuperTypeClass {
//        .init(self.super_type_class_id)
//    }
    
}

//import SwiftUI
//
//struct PropertiesView: ModelContextView {
//    
//    @Environment(\.modelContext) public var modelContext
//
//    @Query private var properties: [Property]
//    
//    @State var property: Property? = nil
//    
//    var body: some View {
//        NavigationStack {
//            Form {
////                ForEach(properties, content: PropertyView)
//            }
//            .toolbar {
//                
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Add") {
//                        if let result: Property = self.modelContext.insertWithPredicate(Property.mode(.random)) {
//                            let id = "\(result.id)"
//                            print(id.replacingOccurrences("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID")
//                                .replacingOccurrences("(").replacingOccurrences(")").replacingOccurrences("<x-coredata://").replacingOccurrences(">").replacingOccurrences(of: "/", with: " ").split(separator: " ").map { String($0) })
//                            
//                            self.property = result
//                        } else {
//                            self.property = nil
//                        }
//                    }
//                })
//                
//            }
//        }
//                
//    }
//    
////    @ViewBuilder
////    private func PropertyView(_ property: Property) -> some View {
////        Section(property.uuid.uuidString) {
////            SpacedLabel("typeClass", property.typeClass.rawValue)
////            SpacedLabel("superTypeClass", property.superTypeClass.rawValue)
////            SpacedLabel("association", property.association.rawValue)
////            SpacedLabel("rawValue", property.rawValue)
////            
//////            SpacedLabel("type_class_id", property.type_class_id)
//////            SpacedLabel("super_type_class_id", property.super_type_class_id)
//////            SpacedLabel("association_id", property.association_id)
//////            SpacedLabel("content_id", property.content_id)
//////            SpacedLabel("content_rawValue", property.content_rawValue)
////        }
////    }
//    
//}
//
//#Preview {
//    PropertiesView()
//        .modelContainer(.forType(Property.self))
//}
