//
//  ModelContext.swift
//  autosave
//
//  Created by Asia Michelle Serrano on 5/7/25.
//

import Foundation
import SwiftData
import Core


extension ModelContext {
    
    public typealias Enum = Persistent.Model.Enum
    public typealias Model = ModelKit.Model.Interface
    public typealias Builder = ModelKit.Model.Builder.Interface
    
    public enum Action {
        case insert, delete
    }
    
    public func random(_ type: Enum) -> Void {
        switch type {
        case .game: create(self.game)
        case .property: create(self.property)
        case .platform: create(self.platform)
        }
    }
    
    public func delete<T: Model>(_ index: IndexSet, _ models: [T]) -> Void {
        
    }
    
}

private extension ModelContext {
    
    typealias Initializer<B: Builder> = (B) -> B.Model

    func game(_ builder: Game.Builder) -> Game {
        .init(builder: builder)
    }
    
    func property(_ builder: Property.Builder) -> Property {
        .init(builder: builder)
    }
    
    func platform(_ builder: Platform.Builder) -> Platform {
        let s: Property.Builder = .system(builder.system)
        let system: Property = create(s, self.property)
        let f: Property.Builder = .format(builder.format)
        let format: Property = create(f, self.property)
        return Platform(system: system, format: format, builder)
    }
    
    func create<B: Builder>(_ initializer: Initializer<B>) -> Void {
        while true {
            let builder: B = .random
            if self.fetchByCompoundKey(builder) == nil {
                create(builder, initializer)
                break
            }
        }
    }
    
    @discardableResult
    func create<B: Builder>(_ builder: B, _ initializer: Initializer<B>) -> B.Model {
        if let model: B.Model = self.fetchByCompoundKey(builder) {
            return model
        } else {
            let model = initializer(builder)
            self.save(model, .insert)
            return model
        }
    }
    
    func fetchByCompoundKey<B: Builder>(_ builder: B) -> B.Model? {
        self.fetch(first: .getByCompoundKey(model: builder.modelType, builder.compound_key))
    }
    
    func fetch<T: Model>(all: FetchDescriptor<T>) -> [T]? {
        ((try? self.fetch(all)) ?? .defaultValue).optional
    }
    
    func fetch<T: Model>(first: FetchDescriptor<T>) -> T? {
        self.fetch(all: first)?.first
    }
    
    func save<T: PersistentModel>(_ model: T, _ action: Action) {
        do {
            switch action {
            case .insert:
                print("inserting model")
                self.insert(model)
            case .delete:
                print("deleting model")
                self.delete(model)
            }
            try self.save()
        } catch let error {
            fatalError("error saving in model context: \(error.localizedDescription)")
        }
    }
    
//    func delete<T: Model>(model: T) -> Void {
//        if let model = model as? Game {
//            // check the platforms first to see if there are any phantom properties that need to be cleaned up
//            // then check all of the properties from the game and the previous step
//            
//            let platforms = model.platforms
//            let properties = model.properties
//            
//        } else if let model = model as? Property {
//            
//            // check if the filtered games are associated with any platform
//            
//            if model.typeEnum.isPlatform {
//                // get the platforms
//                let platforms = model.platforms
//                // get the properties from the platforms that should also be removed
//                let properties: Property.Array = platforms.flatMap {
//                    $0.deleteFilter(.property, model)
//                }
//                // remove those platforms
//                platforms.forEach { self.save($0, .delete) }
//                // remove those properties
//                properties.forEach { self.save($0, .delete) }
//                
////                let properties: Property.Array = platforms.flatMap { platform in
////                    platform.deleteFilter(.property, { $0 == model })
////                }
//            }
//
//            
//            // check if the games are empty for the property
//        } else if let model = model as? Platform {
//            // check if either of the properties have other platforms it referrences
//            let properties: Property.Array = model.deleteFilter(.property)
//            // remove those properties
//            properties.forEach { self.save($0, .delete) }
//        }
//        
//        self.save(model, .delete)
//    }
    
    func delete<T: Model>(model: T) -> Void {
        if let model = model as? Game {
            // check the platforms first to see if there are any phantom properties that need to be cleaned up
            // then check all of the properties from the game and the previous step
            
            let platforms = model.platforms
            let properties = model.properties
            
            self.save(model, .delete)
            
            // 1) are the games empty?
            // 2)
            
        } else if let model = model as? Property {
            
            // check if the filtered games are associated with any platform
            
            if model.typeEnum.isPlatform {
                // get the platforms
                let platforms = model.platforms
                // get the properties from the platforms that should also be removed
                let properties: Property.Array = platforms.flatMap {
                    $0.deleteFilter(.property, model)
                }
                // remove those platforms
                platforms.forEach { self.save($0, .delete) }
                // remove those properties
                properties.forEach { self.save($0, .delete) }
                
//                let properties: Property.Array = platforms.flatMap { platform in
//                    platform.deleteFilter(.property, { $0 == model })
//                }
            }

            
            // check if the games are empty for the property
        } else if let model = model as? Platform {
            let properties: Property.Array = model.deleteFilter(.property)
            properties.forEach { self.save($0, .delete) }
        }
        
        self.save(model, .delete)
    }
    
    func delete<T: Model>(models: [T]) -> Void {
        models.forEach { self.save($0, .delete) }
    }
    
//    func get<T: Model>(model: T) -> [Attribute.Model] {
//        switch model.persistent {
//        case .game(let game):
//            return game.properties.compactMap(\.attribute).union(game.platforms.flatMap(\.attribute))
//        case .property(let property):
//            <#code#>
//        case .platform(let platform):
//            <#code#>
//        }
//    }
    
}

//fileprivate extension Array where Element: ModelContext.Model {
//    
//    func shouldDelete(_ element: Element) -> Bool {
//        switch self.count {
//        case 0:
//            return true
//        case 1:
//            return self.first?.compound_key == element.compound_key
//        default:
//            return false
//        }
//    }
//    
//}

fileprivate extension Predicate {
    
    static func getByCompoundKey<T: ModelContext.Model>(model: ModelContext.Enum, _ compound_key: String) -> Predicate<T>? {
        switch model {
        case .game:
            return #Predicate<Game> { $0.compound_key == compound_key } as? Predicate<T>
        case .property:
            return #Predicate<Property> { $0.compound_key == compound_key } as? Predicate<T>
        case .platform:
            return #Predicate<Platform> { $0.compound_key == compound_key } as? Predicate<T>
        }
    }
    
    static func getByUUID<T: ModelContext.Model>(model: ModelContext.Enum, _ uuid: UUID) -> Predicate<T>? {
        switch model {
        case .game:
            return #Predicate<Game> { $0.uuid == uuid } as? Predicate<T>
        case .property:
            return #Predicate<Property> { $0.uuid == uuid } as? Predicate<T>
        case .platform:
            return #Predicate<Platform> { $0.uuid == uuid } as? Predicate<T>
        }
    }
    
//    static func contains<T: ModelContext.Model>(model: ModelContext.Enum, _ persistent: Persistent.Model) -> Predicate<T>? {
//        switch model {
//        case .game:
//            switch persistent {
//            case .game:
//                return nil
//            case .property(let property):
//                return #Predicate<Game> { $0.properties.contains(property) } as? Predicate<T>
//            case .platform(let platform):
//                return #Predicate<Game> { $0.platforms.contains(platform) } as? Predicate<T>
//            }
//        case .property:
//            switch persistent {
//            case .game(let game):
//                return #Predicate<Property> { $0.games.contains(game) } as? Predicate<T>
//            case .property(let property):
//                return nil
//            case .platform(let platform):
//                return #Predicate<Property> { $0.platforms.contains(platform) } as? Predicate<T>
//            }
//        case .platform:
//            switch persistent {
//            case .game(let game):
//                return #Predicate<Platform> { $0.games.contains(game) } as? Predicate<T>
//            case .property(let property):
//                return #Predicate<Platform> { $0.properties.contains(property) } as? Predicate<T>
//            case .platform(let platform):
//                return nil
//            }
//        }
//    }
    
}

fileprivate extension FetchDescriptor where T: ModelContext.Model {
    
    static func getByCompoundKey(model: ModelContext.Enum, _ compound_key: String) -> Self {
        .init(predicate: .getByCompoundKey(model: model, compound_key))
    }
    
    static func getByUUID(model: ModelContext.Enum, _ uuid: UUID) -> Self {
        .init(predicate: .getByUUID(model: model, uuid))
    }
    
//    static func contains(model: ModelContext.Enum, _ persistent: Persistent.Model) -> Self {
//        .init(predicate: .contains(model: model, persistent))
//    }
    
//    static func contains<M: ModelContext.Model>(model: ModelContext.Enum, _ m: M) -> Self {
//        .contains(model: model, m.persistent)
//    }
    
}



//    func fetchByCompoundKey<M: Model, T: ModelKit.Interface>(_ t: T) -> M? {
//        let compound_key = t.compound_key
//        let descriptor = FetchDescriptor<M>(predicate: #Predicate<M> { $0.compound_key == compound_key })
//        let results = try? self.fetch(descriptor)
//        return results?.first ?? nil
//    }
    
//    func fetchByCompoundKey(game: Game.Builder?) -> Game? {
//        if let game = game {
//            let compound_key = game.compound_key
//            let descriptor = FetchDescriptor<Game>(predicate: #Predicate<Game> { $0.compound_key == compound_key })
//            let results = try? self.fetch(descriptor)
//            return results?.first
//        } else { return nil }
//    }
//
//    func fetchByCompoundKey(property: Property.Builder?) -> Property? {
//        if let property = property {
//            let compound_key = property.compound_key
//            let descriptor = FetchDescriptor<Property>(predicate: #Predicate<Property> { $0.compound_key == compound_key })
//            let results = try? self.fetch(descriptor)
//            return results?.first
//        } else { return nil }
//    }
//
//    func fetchByCompoundKey(platform: Platform.Builder?) -> Platform? {
//        if let platform = platform {
//            let compound_key = platform.compound_key
//            let descriptor = FetchDescriptor<Platform>(predicate: #Predicate<Platform> { $0.compound_key == compound_key })
//            let results = try? self.fetch(descriptor)
//            return results?.first
//        } else { return nil }
//    }
    
//    func fetchByCompoundKey<B: Builder>(_ builder: B) -> B.Model? {
//        switch builder.modelType {
//        case .game:
//            return fetchByCompoundKey(game: builder as? Game.Builder) as? B.Model
//        case .property:
//            return fetchByCompoundKey(property: builder as? Property.Builder) as? B.Model
//        case .platform:
//            return fetchByCompoundKey(platform: builder as? Platform.Builder) as? B.Model
//        }
//    }

//extension ModelContext {
//    
//    public func add<T: PersistentModel>(_ model: T) {
//        self.insert(model)
//        self.store()
//    }
//    
////    public func add<T: PersistentModelProtocol>(_ model: T) {
////        self.insert(model)
////        self.store()
////    }
//    
////    public func insert(model: Model) {
////        self.insert(model.persistent)
////        self.store()
////    }
//    
////    public func delete(model: Model) {
////        switch model {
////        case .game(let game):
////            let properties = game.properties
////            let platforms = game.platforms
////            self.remove(game)
////            self.remove(properties)
////            self.remove(platforms)
////        case .attribute(let attribute):
////            switch attribute {
////            case .property(let property):
////                let platforms = property.platforms
////                self.remove(property)
////                self.remove(platforms)
////            case .platform(let platform):
////                self.remove(platform)
////            }
////        }
////    }
//
//    public func fetch(_ key: Property.Key) -> PropertyArray? {
//        self.fetch(all: Property.getByKey(key))
//    }
//    
//    public func fetch(_ keyBuilder: Property.Key.Builder) -> PropertyArray? {
//        self.fetch(all: Property.getByKeyBuilder(keyBuilder))
//    }
//    
//    public func fetchByUUID<T: PersistentModelProtocol>(model: Generic.Model.Enum, _ uuid: UUID) -> T? {
//        self.fetch(first: .getByUUID(model: model, uuid))
//    }
////    
////    public func fetchByCompositeKey<T: PersistentModelProtocol>(model: Persistent.Model.Enum, _ strings: StringPair) -> T? {
////        self.fetch(first: .getByCompositeKey(model: model, strings))
////    }
////    
////    public func fetchByCompositeKey<T: PersistentModelProtocol>(_ builder: T.Builder) -> T? {
////        self.fetchByCompositeKey(model: builder.persistentModelType, builder.composite_pair)
////    }
////    
//    public func store() {
//        do {
//            try self.save()
//        } catch let error {
//            fatalError("error saving in model context: \(error.localizedDescription)")
//        }
//    }
//    
//}
//
//private extension ModelContext {
//    
//    func fetch<T: PersistentModelProtocol>(all: FetchDescriptor<T>) -> [T]? {
//        ((try? self.fetch(all)) ?? .defaultValue).optional
//    }
//    
//    func fetch<T: PersistentModelProtocol>(first: FetchDescriptor<T>) -> T? {
//        self.fetch(all: first)?.first
//    }
//    
////    func remove(_ persistent: Model.Persistent) {
////        self.delete(persistent)
////        self.store()
////    }
//    
//    func remove(_ properties: [Property]) {
//        self.remove(properties, { $0.games.isEmpty })
//    }
//    
////    func remove(_ platforms: [Platform]) {
////        let properties: [Property] = platforms.filter { platform in
////            if platform.games.isEmpty || platform.properties.count < 2 {
////                self.delete(platform)
////                return true
////            } else { return false }
////        }.flatMap(\.properties).deduped
////        
////        self.store()
////        
////        self.remove(properties, { $0.platforms.isEmpty })
////    }
//    
//    func remove(_ properties: [Property], _ action: (Property) -> Bool) {
//        properties.forEach { property in
//            if action(property) {
//                self.delete(property)
//            }
//        }
//        self.store()
//    }
//    
//}
//
////
////extension ModelContext {
////    
////    public func fetchCount(_ model: Persistent.Model.Enum) -> Int {
////        switch model {
////        case .game:
////            let desc: GameFetchDescriptor = .init(predicate: .true)
////            return (try? self.fetchCount(desc)) ?? 0
////        case .property:
////            let desc: PropertyFetchDescriptor = .init(predicate: .true)
////            return (try? self.fetchCount(desc)) ?? 0
////        case .relation:
////            let desc: RelationFetchDescriptor = .init(predicate: .true)
////            return (try? self.fetchCount(desc)) ?? 0
////        }
////    }
////    
////    public func remove(_ model: Persistor) -> Void {
////        self.delete(model)
////        self.store()
////    }
////    
////    func move(_ game: GameModel, _ next: GameStatusEnum) -> Void {
////        game.setStatus(next)
////        self.store()
////    }
////    
////    @discardableResult
////    // TODO: Does not work
////    func save(_ builder: GameBuilder) -> GameResult {
////        let current: GameSnapshot = builder.snapshot
////        let composite: GameFetchDescriptor = .getBySnapshot(current)
////        let new: GameModel? = self.fetchModel(composite)
////        
////        if let old: GameModel = self.fetchModel(.getByUUID(builder.uuid)) {
////            if let new: GameModel = new, old.uuid != new.uuid {
////                return .init(new.snapshot, false, .edit)
////            } else {
////                old.updateFromSnapshot(current)
////                
//////                builder.tags.deleted.forEach {
//////                    self.remove(old, $0)
//////                }
//////                
//////                builder.tags.added.forEach {
//////                    self.save(old, $0)
//////                }
////                
////                self.store()
////                return .init(current, true, .edit)
////                
////            }
////        } else {
////            let create: Bool = new != nil
////            if create {
////                let game: GameModel = .fromSnapshot(current)
////                self.add(game)
////            }
////            return .init(current, create, .add)
////        }
////        
////        
////
//////        let uuid: GameFetchDescriptor = .getByUUID(original)
//////        if let old: GameModel = self.fetchModel(uuid) {
//////            if let new: GameModel = new, old.uuid != new.uuid {
//////                return .init(new.snapshot, false, .edit)
//////            } else {
//////                old.updateFromSnapshot(current)
//////                self.store()
//////                return .init(current, true, .edit)
//////            }
//////        } else {
//////            if let new: GameModel = new {
//////                return .init(new.snapshot, false, .add)
//////            } else {
//////                let game: GameModel = .fromSnapshot(current)
//////                self.add(game)
//////                return .init(current, true, .add)
//////            }
//////        }
////    }
////    
////    @discardableResult
////    public func save(_ snapshot: GameSnapshot) -> GameModel? {
////        let composite: GameFetchDescriptor = .getBySnapshot(snapshot)
////        if self.fetchModel(composite) == nil {
////            let game: GameModel = .fromSnapshot(snapshot)
////            self.add(game)
////            return game
////        }
////        return nil
////    }
////    
////    private func save(_ snapshot: PropertySnapshot) -> PropertyModel {
////        if let existing: PropertyModel = self.fetchModel(snapshot) {
////            return existing
////        } else {
////            let property: PropertyModel = .fromSnapshot(snapshot)
////            self.add(property)
////            return property
////        }
////    }
////    
////    // TODO: get rid of dead properties
//////    private func remove(_ snapshot: PropertySnapshot) -> Void {
//////        if let existing: PropertyModel = self.fetchModel(snapshot) {
//////            
//////        }
//////    }
////    
////    private func save(_ category: RelationCategory, _ game: GameModel, _ tag: TagSnapshot) -> Void {
////        let snapshot: RelationSnapshot = .init(category, game, tag)
////        if self.fetchModel(snapshot) == nil {
////            let relation: RelationModel = .fromSnapshot(snapshot)
////            self.add(relation)
////        }
////    }
////    
////    private func remove(_ category: RelationCategory, _ game: GameModel, _ tag: TagSnapshot) -> Void {
////        let snapshot: RelationSnapshot = .init(category, game, tag)
////        if let model: RelationModel = self.fetchModel(snapshot) {
////            self.remove(model)
////        }
////    }
//// 
////    public func save(_ game: GameModel, _ builder: TagBuilder) -> Void {
////        let key: PropertyModel = save(builder.key)
////        switch builder {
////        case .platform:
////            let value: PropertyModel = save(builder.value)
////            save(.tag, game, .fromModel(key, value))
////            save(.property, game, .fromModel(key))
////            save(.property, game, .fromModel(value))
////        default:
////            let snapshot: TagSnapshot = .fromModel(key)
////            save(.tag, game, snapshot)
////            save(.property, game, snapshot)
////        }
////    }
////    
////    private func remove(_ game: GameModel, _ builder: TagBuilder) -> Void {
////        if let key: PropertyModel = self.fetchModel(builder.key) {
////            switch builder {
////            case .platform:
////                if let value: PropertyModel = self.fetchModel(builder.value) {
////                    remove(.tag, game, .fromModel(key, value))
////                    remove(.property, game, .fromModel(key))
////                    remove(.property, game, .fromModel(value))
////                }
////            default:
////                let snapshot: TagSnapshot = .fromModel(key)
////                remove(.tag, game, snapshot)
////                remove(.property, game, snapshot)
////            }
////        }
////    }
////    
////}
////
////private extension ModelContext {
////    
////    func fetchModel(_ desc: GameFetchDescriptor) -> GameModel? {
////        fetchModels(desc).first
////    }
////    
////    func fetchModels(_ desc: GameFetchDescriptor) -> [GameModel] {
////        do {
////            return try self.fetch(desc)
////        } catch {
////            print("error: \(error)")
////            return .init()
////        }
////    }
////    
//////    func fetchModel(_ desc: PropertyFetchDescriptor) -> PropertyModel? {
//////        fetchModels(desc).first
//////    }
////    
////    func fetchModel(_ snapshot: PropertySnapshot) -> PropertyModel? {
////        let composite: PropertyFetchDescriptor = .getByCompositeKey(snapshot)
////        return fetchModels(composite).first
////    }
////    
////    func fetchModels(_ desc: PropertyFetchDescriptor) -> [PropertyModel] {
////        do {
////            return try self.fetch(desc)
////        } catch {
////            print("error: \(error)")
////            return .init()
////        }
////    }
////    
//////    func fetchModel(_ desc: RelationFetchDescriptor) -> RelationModel? {
//////        fetchModels(desc).first
//////    }
//////    
////    func fetchModel(_ snapshot: RelationSnapshot) -> RelationModel? {
////        let composite: RelationFetchDescriptor = .getByCompositeKey(snapshot)
////        return fetchModels(composite).first
////    }
////    
////    func fetchModels(_ desc: RelationFetchDescriptor) -> [RelationModel] {
////        do {
////            return try self.fetch(desc)
////        } catch {
////            print("error: \(error)")
////            return .init()
////        }
////    }
////    
////    func add(_ model: Persistor) -> Void {
////        self.insert(model)
////        self.store()
////    }
////    
//    func store() {
//        do {
//            try self.save()
//        } catch let error {
//            fatalError("error saving in model context: \(error.localizedDescription)")
//        }
//    }
////    
////}
////
