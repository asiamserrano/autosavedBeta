//
//  ModelKit.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core
import SwiftData
import SwiftUI

public enum ModelKit {
    
    public protocol Interface {
        typealias ModelEnum = Persistent.Model.Enum
        static var modelType: ModelEnum { get }
        var compound_key: String { get }
        var modelType: ModelEnum { get }
    }
    
    public enum Model {
        
        public enum View {
            public protocol Interface: SwiftUI.View {
                var modelContext: ModelContext { get }
            }
        }
        
        public protocol Interface: PersistentModel, ModelKit.Interface {
            associatedtype Builder: ModelKit.Model.Builder.Interface where Builder.Model == Self
            typealias Compound = Builder.Compound
            typealias Array = [Self]
            
            typealias Implementation = Persistent.Interface.Implementation
            typealias Instance = Persistent.Interface.Instance
            
            var uuid: UUID { get }
            var builder: Builder { get }
            var rawValue: String { get }
            var debug: Builder.Debug { get }
            var persistent: Persistent.Model { get }
        }
        
        public enum Builder {
            public protocol Interface: BuilderKit.Interface, ModelKit.Interface  {
                associatedtype Model: ModelKit.Model.Interface
                typealias Debug = Builder.Debug.Container
                var debug: Debug { get }
            }
            
            public enum Debug {
                public typealias Container = String.Container
            }
        }
        
    }
    
}

extension ModelKit.Model.View.Interface {
    
    public func save() {
        do {
            try self.modelContext.save()
        } catch let error {
            fatalError("error saving in model context: \(error.localizedDescription)")
        }
    }
    
    public func insert<T: PersistentModel>(_ model: T) -> Void {
        withAnimation {
            self.modelContext.insert(model)
            self.save()
        }
    }

    public func delete<T: PersistentModel>(_ model: T) -> Void {
        withAnimation {
            self.modelContext.delete(model)
            self.save()
        }
    }
    
}

extension ModelKit.Model.Builder.Interface {
    
    public var compound_key: String { self.id }
    
    public var modelType: ModelEnum {
        Self.modelType
    }
    
}

extension ModelKit.Model.Interface {
        
    public var compound: Compound {
        self.builder.compound
    }
    
    public static var modelType: ModelEnum {
        Self.Builder.modelType
    }
    
    public var modelType: ModelEnum {
        self.builder.modelType
    }
    
    public typealias PersistentEnum = Persistent.Model.Enum
    
    public func deleteFilter<T: Implementation>(_ desired: PersistentEnum, _ ignore: T? = nil) -> [T] {
        self.instances(desired).filter {
            if let ignore = ignore, ignore == $0 {
                return false
            } else {
                let array: [Self] = $0.instances(self.modelType)
                return array.count == 0 || array == [self]
            }
        }
    }
    
    private func instances<I: Implementation>(_ i: PersistentEnum) -> [I] {
        self.instances(i) as? [I] ?? .defaultValue
    }
    
    private func instances(_ i: PersistentEnum) -> [Instance] {
        // get my array of instances for i (ex: platform will return [Property] for i == .properties)
        switch self.persistent {
        case .game(let game):
            switch i {
            case .game: return .defaultValue
            case .property: return game.properties
            case .platform: return game.platforms
            }
        case .property(let property):
            switch i {
            case .game: return property.games
            case .property: return .defaultValue
            case .platform: return property.platforms
            }
        case .platform(let platform):
            switch i {
            case .game: return platform.games
            case .property: return platform.properties
            case .platform: return .defaultValue
            }
        }
    }
    
}
