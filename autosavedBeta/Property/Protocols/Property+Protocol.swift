//
//  Property+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public protocol PropertyProtocol: IdentifiableProtocol {
    
    var typeEnum: TypeEnum { get }
    
    func get(_ v: VariableEnum) -> String?
        
}
