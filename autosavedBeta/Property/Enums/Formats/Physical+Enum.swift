//
//  Physical+Enum.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public enum PhysicalEnum: FormatProtocol {
    
    public static var defaultFormat: DefaultFormat { .physical }

    case disc, cartridge, card
}
