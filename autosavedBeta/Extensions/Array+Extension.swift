//
//  Array+Extension.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

public extension Array where Element == [Any] {
    
    var compacted: [Element.Element] {
        self.flatMap { $0 }
    }
    
}

public extension Array where Element: Equatable {
    
    func doesntContain(_ item: Element) -> Bool {
        !self.contains(item)
    }
    
}
