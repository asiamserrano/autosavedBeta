//
//  BuilderKit.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/14/26.
//

import Foundation
import Core

public enum BuilderKit {
    
    public typealias Interface = ProtocolKit.Random.Compound.Interface
    
    public enum Implementation {
        
        public protocol Interface: BuilderKit.Interface {
            typealias Instance = any BuilderKit.Interface
            typealias Container = Implementation.Container<Self>
            associatedtype Enum: Enumerable
            var type: Enum { get }
            var instance: Instance { get }
        }
        
        public struct Container<T>: Containable.Interface where T: Interface {

            public typealias Instance = Containable.Instance<T.Enum, T.Collector>
            public typealias Element = Self.Instance.Element

            private var instance: Instance
            
            public init(storage: Storage) {
                self.instance = .init(storage: storage)
            }
            public var storage: Storage {
                self.instance.storage
            }
            
        }
        
    }
    
}

extension BuilderKit.Implementation.Interface {
    
    public var compound: Compound {
        .init(first: self.type, last: self.instance)
    }
    
//    public var id: String {
//        let array = [self.type.id, self.instance.id]
//        return array.joined(separator: " | ")
//    }
    
}


//extension Core.Collector where Element: BuilderKit.Interface {
//    
////    public var myFoo: String { .defaultValue }
//    
//}

//public struct SubjectContainer<Subject>: Containable.Interface where Subject: BuilderKit.Implementation.Interface {
//
//    public typealias Element = Containable.E.Instance<Subject.Enum, Subject.Collector>
//
//    public var storage: Storage
//    
//    public init(storage: Storage) {
//        self.storage = storage
//    }
//    
//}

extension BuilderKit.Implementation.Container {
        
    public typealias E = Value.Element
//    public typealias Enum = Key.Enum
//    
//    public func key(_ e: E) -> Key { e.type }
    
//    public typealias ValueElement = Value.Element
//    public typealias Collection = ValueElement.Collection
//    public typealias Enum = Collection.Enum

    //    public typealias KeyType =
//    public typealias ValueType = KeyType.Builder
    
    
}
