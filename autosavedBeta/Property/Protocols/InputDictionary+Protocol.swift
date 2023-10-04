//
//  InputDictionary+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

public protocol InputDictionaryProtocol {
    
    var inputs: [InputEnum: [String: String]] { get }
    
    func removeInput(_ index: Int) -> Void
    func removeInput(_ key: InputEnum, _ index: Int) -> Void
    
    func insertInput(_ i: InputEnum, _ s: String) -> Void
    
}

public extension InputDictionaryProtocol {
    
    var inputKeys: [InputEnum] {
        self.inputs.keys.sorted()
    }
    
    var isInputsEmpty: Bool {
        self.inputKeys.isEmpty
    }
    
    func getKeys(_ i: InputEnum) -> [String] {
        self.inputs[i]?.keys.sorted() ?? .init()
    }
    
    func getValues(_ i: InputEnum) -> [String] {
        self.inputs[i]?.values.sorted() ?? .init()
    }
    
    func isInputEmpty(_ i: InputEnum) -> Bool {
        self.inputs[i]?.isEmpty ?? true
    }
    
}
