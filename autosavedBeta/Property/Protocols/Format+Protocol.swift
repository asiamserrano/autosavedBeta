//
//  Format+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public typealias DefaultFormat = FormatEnum.DefaultEnum

public protocol FormatProtocol: IterableProtocol {
    
    static var defaultFormat: DefaultFormat { get }

}

extension FormatProtocol {
    
    var icon: String {
        Self.defaultFormat.icon
    }
    
}
