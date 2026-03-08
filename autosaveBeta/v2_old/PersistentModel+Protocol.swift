//
//  PersistentModel+Protocol.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/2/26.
//

import Foundation
import Core
import SwiftUI
import SwiftData
import Combine

//public protocol PersistentModelProtocol: ObservableObject, Identifiable, ClassNameProviding, UUID.Providing {
//    var toString: String { get }
//}
//
//extension PersistentModelProtocol {
//    
//    public typealias Namespace = V3UUIDNamespace
//        
//    public static var namespace: V3UUIDNamespace { .init(persistent: Self.self) }
//    
//    public var namespace: V3UUIDNamespace {
//        Self.namespace
//    }
//    
//}

public protocol PersistentModelProtocol: ObservableObject, SelfTypeProviding, ClassNameProviding, UUID.Providing {}

extension View {
    
    @ViewBuilder
    public func ExampleModelView(_ header: String, _ array: [ExampleBase]) -> some View {
        Section(header) {
            ForEach(array, id:\.id) {
                Text($0.toString)
            }
        }
    }
    
}
