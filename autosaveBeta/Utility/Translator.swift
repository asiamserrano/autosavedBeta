//
//  Translator.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/17/26.
//

import Foundation
import Core

public struct Translator {
    
   
    
    
    // Persistent.Model.Builder
    /*
     case game(Game.Builder)
     case property(Property.Builder)
     case platform(Platform.Builder)
     */
    
    // Attribute.Builder
    /*
     case input(Input.Builder)
     case mode(Mode.Enum)
     case platform(Platform.Builder)
     */
    
    // Property.Builder
    /*
     case input(Input.Builder)
     case mode(Mode.Enum)
     case system(System.Builder)
     case format(Format.Builder)
     */
    
    public typealias AttributeBuilders = [Attribute.Builder]
    public typealias PropertyBuilders = Property.Builder.Collector
    
    public typealias AttributeCollector = Attribute.Builder.Collector
    public typealias PropertyCollector = Property.Builder.Collector
    
    public static func toProperties(_ attrs: AttributeBuilders) -> PropertyCollector {
        .init(collection: attrs.flatMap(\.properties))
    }
    
}

/*
 // 1. [Property] and [Platform] from Game to Attributes Collector
    
 // 2. Attributes Collector to [Property] and [Platform] for Game
 // 3. Property Builder Collection
 
 */
