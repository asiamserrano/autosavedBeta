//
//  CoreModelExtensions.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/22/26.
//

import Foundation
import Core
import SwiftData
import SwiftUI

public protocol UUIDPersistentModel: PersistentModel {
    
    static func insertPredicate(_ uuid: UUID) -> Predicate<Self>

    var uuid: UUID { get }
    
}

extension UUIDPersistentModel {
    
    public var insertPredicate: Predicate<Self> {
        Self.insertPredicate(self.uuid)
    }
    
}

public protocol ModelContextView: View {
    var modelContext: ModelContext { get }
}

extension ModelContextView {
    
    @discardableResult
    public func insert<T: PersistentModel>(_ model: T) -> T? {
        self.modelContext.save(model, action: .insert)
    }
    
    @discardableResult
    public func delete<T: PersistentModel>(_ model: T) -> T? {
        self.modelContext.save(model, action: .delete)
    }
    
}

extension ModelContainer {
    
    private static let STORE_PATH = "/Users/asiaserrano/xcode/autosaveBeta/PreviewStores"
    
    private static func createStoreURL(_ name: String) -> URL {
        let storeName = "\(name)PreviewStore"
        let filePath = "\(STORE_PATH)/\(storeName).sqlite"

        if FileManager.default.fileExists(atPath: filePath) {
            print("File at: '\(filePath)' already exists. Skipping creation.")
        } else {
            let success = FileManager.default.createFile(atPath: filePath, contents: nil)
            if success {
                print("File created successfully at: \(filePath)")
            } else {
                print("Failed to create file at: \(filePath)")
            }
        }
        
        return URL(fileURLWithPath: filePath)
    }
    
    public static func forType(_ name: String, types: [any PersistentModel.Type]) -> ModelContainer {
        do {
            let url = createStoreURL(name)
            let schema: Schema = .init(types)
            let config = ModelConfiguration(url: url)
            let container: ModelContainer = try .init(for: schema, configurations: config)
            container.mainContext.autosaveEnabled = false
            container.mainContext.undoManager = .init()
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    public static func forType<T: PersistentModel>(_ type: T.Type) -> ModelContainer {
        let storeName = String(describing: type)
        return forType(storeName, types: [type])
    }
    
//    private enum Stores {
//        case diet, defaultValue
//        
//        var fileName: String {
//            switch self {
//            case .diet:
//                return "DietPreviewStore1"
//            case .defaultValue:
//                return "autosaveBetaStore"
//            }
//        }
//        
//        init<T: PersistentModel>(_ t: T.Type) {
//            if t is Diet.Type {
//                self = .diet
//            } else {
//                self = .defaultValue
//            }
//        }
//        
//    }
    
    private convenience init(memory: Bool) {
        do {
            let schema: Schema = .init([
//                Employee.self, Trip.self, BusinessTrip.self, PersonalTrip.self
//                ExampleAttribute.self, ExampleProperty.self, ExamplePlatformProperty.self, ExampleGame.self, ExampleInputProperty.self,
//                ExampleModeProperty.self, ExampleSystemProperty.self, ExampleFormatProperty.self, ExamplePlatform.self
            ])
            let config: ModelConfiguration = .init(schema: schema, isStoredInMemoryOnly: memory)
            try self.init(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    public static var preview: ModelContainer {
        let container: ModelContainer = .init(memory: true)

        container.mainContext.autosaveEnabled = false
        container.mainContext.undoManager = .init()
        
        return container
    }
    
}

extension ModelContext {
    
    @discardableResult
    public func insertWithPredicate<T: UUIDPersistentModel>(_ t: T) -> T? {
        do {
            if self.fetch(t.insertPredicate) == nil {
                print("creating new instance of diet")
                self.insert(t)
                try self.save()
                return t
            }
//            else {
//                let id = "\(t.id)".replacingOccurrences("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID")
//                    .replacingOccurrences("(").replacingOccurrences(")").replacingOccurrences("<x-coredata://").replacingOccurrences(">").replacingOccurrences(of: "/", with: " ")
//                print("found existing instance: \(id)")
//            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
//    @discardableResult
//    public func maybeSave(_ diet: Diet) -> Diet? {
//        do {
//            let uuid = diet.uuid
//            print("uuid: \(uuid.uuidString)")
//
//            let predicate = #Predicate<Diet> { $0.uuid == uuid }
//            print("created predicate")
//
//            let fetchDescriptor = FetchDescriptor<Diet>(predicate: predicate)
//            print("created fetch descriptor")
//
//            let results: [Diet] = (try? self.fetch(fetchDescriptor)) ?? .defaultValue
//            print("fetched diets")
//
//            if let exists = results.first {
//                print("found instance of diet")
//
//                let id = "\(exists.id)".replacingOccurrences("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID")
//                    .replacingOccurrences("(").replacingOccurrences(")").replacingOccurrences("<x-coredata://").replacingOccurrences(">").replacingOccurrences(of: "/", with: " ")
//                print("found existing diet: \(id)")
//            } else {
//                print("creating new instance of diet")
//                self.insert(diet)
//                try self.save()
//                return diet
//            }
//        } catch {
//            print("error: \(error)")
//        }
//        return nil
//    }
    
//    @discardableResult
//    public func maybeSave(_ diet: Diet) -> Diet? {
//        do {
//            let uuid = diet.uuid
//            print("uuid: \(uuid.uuidString)")
//
//            let predicate = #Predicate<Diet> { $0.uuid == uuid }
//            print("created predicate")
//
//            let fetchDescriptor = FetchDescriptor<Diet>(predicate: predicate)
//            print("created fetch descriptor")
//
//            let results: [Diet] = (try? self.fetch(fetchDescriptor)) ?? .defaultValue
//            print("fetched diets")
//
//            if let exists = results.first {
//                print("found instance of diet")
//
//                let id = "\(exists.id)".replacingOccurrences("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID")
//                    .replacingOccurrences("(").replacingOccurrences(")").replacingOccurrences("<x-coredata://").replacingOccurrences(">").replacingOccurrences(of: "/", with: " ")
//                print("found existing diet: \(id)")
//            } else {
//                print("creating new instance of diet")
//                self.insert(diet)
//                try self.save()
//                return diet
//            }
//        } catch {
//            print("error: \(error)")
//        }
//        return nil
//    }

    @discardableResult
    public func save<T: PersistentModel>(_ t: T, action: Action? = nil) -> T? {
//        
//        do {
//            self.insert(t)
//            try self.save()
//            return t
//        } catch {
//            print("error while in model context 'save' function for \(t.persistentModelID) with error: \(error.localizedDescription)")
//            self.delete(t)
//            try? self.save()
//            return nil
//        }
        
//        do {
//            if let action = action { execute(action: action, t) }
//            try ModelContext.save(self)
//        } catch let error {
//            switch action {
//            case .insert:
//                print("error while in model context 'save' function for \(t.persistentModelID) with error: \(error.localizedDescription)")
////                try? self.save( { self.delete(t) })
//                
//                self.delete(t)
//                try? self.save()
//                
//                return nil
//            default:
//                let message = "Issue on \(t.persistentModelID) in model context with error: \(error.localizedDescription)"
//                print(message)
//                fatalError(message)
//            }
//        }
        
        return nil
    }

    public func fetch<T: PersistentModel>(_ predicate: Predicate<T>) -> [T] {
        do {
            return try self.fetch(.init(predicate: predicate))
        } catch {
            print("error: \(error)")
            return .defaultValue
        }
    }
    
    public func fetch<T: PersistentModel>(_ predicate: Predicate<T>) -> T? {
        self.fetch(predicate).first
    }
    
    public enum Action: Enumerable { case insert, delete }
    
    private func execute<T: PersistentModel>(action: Action, _ t: T) -> Void {
        switch action {
        case .insert:
            self.insert(t)
        case .delete:
            self.delete(t)
        }
    }
    
    private static func save(_ mc: ModelContext) throws {
        try mc.save()
    }
    
//    private func save(_ action: () -> Void) -> Void {
//        do {
//            try self.save()
//        } catch {
//            print("error in model context 'save' function with error: \(error.localizedDescription)")
//        }
//    }
    
//    private func execute<T: PersistentModel>(action: Action, _ t: T) throws {
//        switch action {
//        case .insert:
//            try self.save( { self.insert(t) })
//        case .delete:
//            try self.save( { self.delete(t) })
//        }
//    }
//    
//    private func save(_ action: () -> Void) throws {
//        action()
//        try self.save()
//    }
    
    
}

//private struct ModelContainerKey: EnvironmentKey {
//    static let defaultValue: ModelContainer? = nil
//}
//
//extension EnvironmentValues {
//    var modelContainerRef: ModelContainer? {
//        get { self[ModelContainerKey.self] }
//        set { self[ModelContainerKey.self] = newValue }
//    }
//}
//
//extension View {
//    func provideModelContainer(_ container: ModelContainer) -> some View {
//        environment(\.modelContainerRef, container)
//    }
//}

extension Predicate {
    
    public typealias ExampleModel = ExampleBase.BaseIdentifier
    
    public static func byUUID<T: PersistentModelProtocol>(model: ExampleModel, _ uuid: UUID) -> Predicate<T>? {
        switch model {
        case .game:
            return #Predicate<ExampleGame> { $0.uuid == uuid } as? Predicate<T>
        case .input:
            return #Predicate<ExampleInputProperty> { $0.uuid == uuid } as? Predicate<T>
        case .platform:
            return #Predicate<ExamplePlatform> { $0.uuid == uuid } as? Predicate<T>
        case .mode:
            return #Predicate<ExampleModeProperty> { $0.uuid == uuid } as? Predicate<T>
        case .system:
            return #Predicate<ExampleSystemProperty> { $0.uuid == uuid } as? Predicate<T>
        case .format:
            return #Predicate<ExampleFormatProperty> { $0.uuid == uuid } as? Predicate<T>
        }
    }
    
    public static func byPersistentIdentifier<T: PersistentModelProtocol>(model: ExampleModel, _ id: PersistentIdentifier) -> Predicate<T>? {
        switch model {
        case .game:
            return #Predicate<ExampleGame> { $0.persistentModelID == id } as? Predicate<T>
        case .input:
            return #Predicate<ExampleInputProperty> { $0.persistentModelID == id } as? Predicate<T>
        case .platform:
            return #Predicate<ExamplePlatform> { $0.persistentModelID == id } as? Predicate<T>
        case .mode:
            return #Predicate<ExampleModeProperty> { $0.persistentModelID == id } as? Predicate<T>
        case .system:
            return #Predicate<ExampleSystemProperty> { $0.persistentModelID == id } as? Predicate<T>
        case .format:
            return #Predicate<ExampleFormatProperty> { $0.persistentModelID == id } as? Predicate<T>
        }
    }
    
}

extension FetchDescriptor where T: PersistentModelProtocol {
    
    public typealias ExampleModel = ExampleBase.BaseIdentifier
        
    public static func byUUID(model: ExampleModel, _ uuid: UUID) -> Self {
        .init(predicate: .byUUID(model: model, uuid))
    }
    
    public static func byPersistentIdentifier(model: ExampleModel, _ id: PersistentIdentifier) -> Self {
        .init(predicate: .byPersistentIdentifier(model: model, id))
    }
    
}


//
//extension FetchDescriptor {
//    
//    public static func byPersistentIdentifier<T: PersistentModel>(_ persistentModelID: PersistentIdentifier) -> FetchDescriptor<T> {
//        .init
//    }
//    
//    public static func byUUID(_ uuid: UUID) -> Predicate<ExampleBase> {
//        #Predicate { $0.uuid == uuid }
//    }
//    
//}

//extension PersistentIdentifier {
//    
////    public var elements: [String] {
////        
////        let str = "\(self)".replacing("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID", with: "")
////        
////        //
////        
////        str = str.replacingOccurrences("(").replacingOccurrences(")")
////
//////        (0xbeaad62ef4089cf6 <x-coredata://9439C931-590D-4AE6-B1B5-119EC0671D75/Breed/p1>)))
////        
////    }
//    
//}


