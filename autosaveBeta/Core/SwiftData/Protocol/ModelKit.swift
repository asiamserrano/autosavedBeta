//
//  ModelKit.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core
import SwiftData

public enum ModelKit {
    
    public protocol Interface: Randomizable {}
    
    public enum Model {
        
        public protocol Interface: PersistentModel, ModelKit.Interface {
            
            associatedtype Builder: ModelKit.Model.Builder.Interface where Builder.Model == Self
            
            typealias Compound = Builder.Compound

            init(builder: Builder)
            
            var uuid: UUID { get }
            var builder: Builder { get }
            var compound_key: String { get }
                        
        }
        
        public enum Builder {
            public protocol Interface: BuilderKit.Interface  {
                associatedtype Model: ModelKit.Model.Interface
            }
        }
        
    }
    
}

extension ModelKit.Model.Builder.Interface {
    
    public var compound_key: String {
        self.id
    }
    
}

extension ModelKit.Model.Interface {
    
    public static var random: Self {
        .init(builder: .random)
    }
    
    public var compound: Compound {
        self.builder.compound
    }
    
}
