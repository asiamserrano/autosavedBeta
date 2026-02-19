//
//  Property+Builder.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core
import SwiftUI

struct PropertyBuilderView: View {
    
//    let builder: Property.Builder = .input(.init(.series, "series"))
    let builders: Property.Builder.Collector = .init(.mode(.single), .format(.physical(.disc)), .input(.series, "Grand Theft Auto"))
        
//    var data: [String] {
//        [
//            self.builder.type.id,
//            self.builder.type.rawValue,
//            self.builder.value.id,
//            self.builder.value.rawValue,
//            self.builder.compound_key
//        ]
//    }
     
    var body: some View {
        NavigationStack {
            Form {
                ForEach(self.builders) { builder in
                    Section {
                        ForEach(getData(builder), id:\.self) {
                            Text($0)
                        }
                    }
                }
            }
        }
    }
    
    private func getData(_ builder: Property.Builder) -> [String] {
        [
            builder.type.id,
            builder.type.rawValue,
            builder.value.id,
            builder.value.rawValue,
            builder.compound_key
        ]
    }
    
}

#Preview {
    PropertyBuilderView()
}


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
////    public func asEnumerable<T: Enumerable>(_ type: T.Type = T.self) -> T? {
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
