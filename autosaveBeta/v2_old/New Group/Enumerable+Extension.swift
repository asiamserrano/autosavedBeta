//
//  Enumerable+Extension.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/25/26.
//

import Foundation
import Core
import SwiftData

extension Enumerable {
    
    public typealias Namespace = V3UUIDNamespace
        
    public static var namespace: V3UUIDNamespace { .init(enumerable: Self.self) }
    
    public var namespace: V3UUIDNamespace {
        Self.namespace
    }
    
    public var uuid: UUID {
        self.namespace.uuid(enumerable: self)
    }
    
}
