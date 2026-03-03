//
//  Property+Builder.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core
import SwiftUI

extension Property.Builder: BuilderKit.Implementation.Interface {
    
    public static var modelType: ModelEnum { .property }
    
    public static var random: Self { .random(Enum.random) }

    public static func random(_ type: Enum) -> Self {
        switch type {
        case .input(let i): return .input(.init(i, .random))
        case .mode: return .mode(.random)
        case .system: return .system(.random)
        case .format: return .format(.random)
        }
    }
    
    public static func random(_ type: Property.Enum) -> Self {
        switch type {
        case .input: return .input(.random)
        case .mode: return .mode(.random)
        case .system: return .system(.random)
        case .format: return .format(.random)
        }
    }
    
    public static func input(_ type: Input.Enum, _ value: String) -> Self {
        .input(.init(type, value))
    }
    
    public typealias Model = Property
    public typealias Enum = Property.Enum.Builder
    
    public var type: Enum {
        switch self {
        case .input(let i): return .input(i.type)
        case .mode: return .mode
        case .system(let s): return .system(s.type)
        case .format(let f): return .format(f.type)
        }
    }
    
    public var typeEnum: Enum.Enum {
        self.type.type
    }
        
    public var instance: Instance {
        switch self {
        case .input(let i): return i
        case .mode(let m): return m
        case .system(let s): return s
        case .format(let f): return f
        }
    }
    
    public var value: Str {
        switch self {
        case .input(let i): return i.str
        case .mode(let m): return .init(enumerable: m)
        case .system(let s): return .init(enumerable: s)
        case .format(let f): return .init(enumerable: f)
        }
    }
    
    public var debug: Debug {
        .init(storage: [
            "-id": self.id,
            "type id": self.type.id,
            "type rawValue": self.type.rawValue,
            "typeEnum id": self.typeEnum.id,
            "typeEnum rawValue": self.typeEnum.rawValue,
            "value id": self.value.id,
            "value rawValue": self.value.rawValue,
            "instance id": self.instance.id
        ])
    }
    
}

//struct PropertyBuilderView: View {
//
//    @State private var builder: Property.Builder
//    
//    init(builder: Property.Builder) {
//        self._builder = .init(initialValue: builder)
//    }
//    
//    init() {
//        self.init(builder: .random)
//    }
//
//    var body: some View {
//        ForEach(self.builder.debugStrings, id:\.self) {
//            Text($0)
//        }
//    }
//    
//}
//
//#Preview {
//    Previewer { PropertyBuilderView() }
//}


//extension Property.Builder {
//    
//  
//    
//    // Unable to parse key: 3_os_SystemEnum
//    
////        public init(model: Model) {
////            switch Key.Builder(model.key_builder_id) {
////            case .input(let inputEnum): self = .input(.init(inputEnum, model.value_rawValue))
////            case .mode: self = .mode(.init(model.value_id))
////            case .system: self = .system(.init(model.value_id))
////            case .format: self = .format(.init(model.value_id))
////            }
////        }
//    
////        public var attributeBuilder: Generic.Attribute.Builder? {
////            switch self {
////            case .input(let i): return .input(i)
////            case .mode(let m): return .mode(m)
////            default: return nil
////            }
////        }
//
////    public func asEnumerable<T: Enumerable.Interface>(_ type: T.Type = T.self) -> T? {
////        switch self {
////        case .mode(let modeEnum):
////            return modeEnum as? T
////        case .system(let systemBuilder):
////            return systemBuilder as? T
////        case .format(let formatBuilder):
////            return formatBuilder as? T
////        default: return nil
////        }
////    }
//
////        public var id: Int { self.hashValue }
//    
////    public var type: Property.Enum {
////        self.builderType.type
////    }
////    
////    public var builderType: Property.Enum.Builder {
////        switch self {
////        case .input(let i): return .input(i.type)
////        case .mode: return .mode
////        case .system(let s): return .system(s.system)
////        case .format(let f): return .format(f.format)
////        }
////    }
//    
////        public var valueCompound: Compound.Str {
////            switch self {
////            case .input(let i): return .init(string: i.rawValue)
////            case .mode(let m): return .init(enumerable: m)
////            case .system(let s): return .init(enumerable: s)
////            case .format(let f): return .init(enumerable: f)
////            }
////        }
////
////        public var compoundKey: Compound.Key {
////            .init(key: self.keyBuilder.id, value: self.valueCompound.id)
////        }
////
////        public var rawValue: String {
////            "(\(self.keyBuilder.rawValue)) \(self.valueCompound.rawValue)"
////        }
////
////        public var modelBuilder: Generic.Model.Builder {
////            .property(self)
////        }
//
//}
//

