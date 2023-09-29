//
//  String?+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation

public extension String? {
    
    var toString: String {
        self ?? .empty
    }
    
//    func equals(_ it: any IterableProtocol) -> Bool {
//        self == it.key || self == it.value
//    }
    
}
