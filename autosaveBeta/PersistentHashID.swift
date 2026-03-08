//
//  PersistentHashID.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/4/26.
//

import Foundation
import Core
import SwiftData

public protocol PersistentProtocol: ClassNameProviding {
    
//    var persistentID: UUID { get } // stable, non changing
//    var strictHashID: UUID { get } // comes from _title
//    var fuzzyHashID: UUID { get } // comes from canon _title
    
}

public struct PersistentHashID<T>: HashIDProviding where T: PersistentProtocol {
    public let strict: UUID   // sensitive to punctuation/case
    public let fuzzy: UUID    // tolerant canonicalization
}
