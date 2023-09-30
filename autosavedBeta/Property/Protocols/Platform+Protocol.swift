//
//  Platform+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public typealias PlatformFamily = PlatformEnum.FamilyEnum
public typealias PlatformType = PlatformEnum.TypeEnum

public protocol PlatformProtocol: IterableProtocol {
    
    static var family: PlatformFamily { get }
    static var allPlatforms: [PlatformEnum] { get }
    
    var typeEnum: PlatformType { get }
    var physicalFormat: PhysicalEnum { get }
    var digitalFormats: [DigitalEnum] { get }
    
}

extension PlatformProtocol {
    
    public var physicalFormat: PhysicalEnum { .disc }
    
}
