//
//  Dictionary+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public protocol DictionaryProtocol: ObservableObject {
    
    init()
    init(_ ns: NSSet?)
    
    var builders: [any BuilderProtocol] { get }
    
}

extension DictionaryProtocol {
    
//    init(_ arr: [Property]) {
//        self.init(arr.transform())
//    }
    
    public func build(_ con: Context) -> NSSet {
        .init(array: self.builders.map(con.fetchProperty))
    }
    
}
