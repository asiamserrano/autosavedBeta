//
//  PropertyDictionary+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/30/23.
//

import Foundation

public protocol PropertyDictionaryProtocol {
    
    func equals(_ other: Self, _ hash: HashEnum) -> Bool
    
}
