//
//  ExampleModels.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/2/26.
//

import SwiftUI
import SwiftData
import Core
import Combine

//public protocol PersistentModelProtocol: ObservableObject, Identifiable, ClassNameProviding, UUID.Providing {
//    var toString: String { get }
//}
//
//extension PersistentModelProtocol {
//    
//    public typealias Namespace = V3UUIDNamespace
//        
//    public static var namespace: V3UUIDNamespace { .init(persistent: Self.self) }
//    
//    public var namespace: V3UUIDNamespace {
//        Self.namespace
//    }
//    
//}

@Model @available(iOS 26, *)
public class ExampleBase: PersistentModelProtocol {
    
    public static var final: [ExampleBase.Type] {
        [
            ExampleGame.selfType, ExampleInputProperty.selfType,
            ExampleModeProperty.selfType, ExamplePlatform.selfType,
            ExampleSystemProperty.selfType, ExampleFormatProperty.selfType
        ]
    }
    
    public enum BaseIdentifier: Enumerable {
        case game, input, mode, platform, system, format
    }

    public typealias Namespace = V3UUIDNamespace
    
    public static var namespace: V3UUIDNamespace {
        .init(persistent: Self.self)
    }
    
    public private(set) var uuid: UUID
        
    public var namespace: V3UUIDNamespace {
        Self.namespace
    }
    
    public var toString: String { .defaultValue }
    
    fileprivate init(uuid: UUID) {
        self.uuid = uuid
    }
    
    fileprivate func setUUID(_ uuid: UUID) -> Void {
        self.uuid = uuid
    }
    
    fileprivate func setUUID(_ ns: Namespace, _ title: String, _ release: Date) -> Void {
        self.uuid = ns.uuid(title: title, release: release)
    }
    
}

@Model @available(iOS 26, *)
public final class ExampleGame: ExampleBase, Randomizable {
    
    public static var random: ExampleGame {
        .init(title: .random, release: .random)
    }
    
    public private(set) var title: String
    public private(set) var release: Date
    
    @Relationship(inverse: \ExampleAttribute.games)
    public var attributes: [ExampleAttribute]
    
    private init(title: String, release: Date) {
        self.title = title
        self.release = release
        self.attributes = .defaultValue
        super.init(uuid: Self.namespace.uuid(title: title, release: release))
    }
    
    public var properties: [ExampleProperty] {
        let array: [ExampleProperty] = self.attributes.flatMap(\.properties)
        let set: Set<ExampleProperty> = Set(array)
        return set.sorted(by: { $0.propertyIdentifier < $1.propertyIdentifier })
    }
    
    public func insert(_ attribute: ExampleAttribute) -> Void {
        self.attributes = self.attributes + [attribute]
    }
    
    public func remove(_ attribute: ExampleAttribute) -> Void {
        self.attributes = self.attributes.filter { $0.uuid != attribute.uuid }
    }
    
    public override var toString: String {
        "\(title.trimmed) (\(self.release.dashes))"
    }
    
    public var titleBinding: Binding<String> {
        .init(get: {
            self.title
        }, set: { newValue in
            self.title = newValue
            self.setUUID()
        })
    }
    
    public var releaseBinding: Binding<Date> {
        .init(get: {
            self.release
        }, set: { newValue in
            self.release = newValue
            self.setUUID()
        })
    }
    
    private func setUUID() -> Void {
        self.setUUID(self.namespace.uuid(title: title, release: release))
    }
    
}

@Model @available(iOS 26, *)
public class ExampleAttribute: ExampleBase {
    
    public enum AttributeIdentifier: Enumerable {
        case input, mode, platform
    }
    
    public var games: [ExampleGame]
    
    fileprivate override init(uuid: UUID) {
        self.games = []
        super.init(uuid: uuid)
    }
    
    public func insert(_ game: ExampleGame) {
        self.games = self.games + [game]
    }
    
    public func remove(_ game: ExampleGame) -> Void {
        self.games = self.games.filter { $0.uuid != game.uuid }
    }
    
    public override var toString: String { .defaultValue }
    
    public var properties: [ExampleProperty] { .defaultValue }
    
}

@Model @available(iOS 26, *)
public class ExampleProperty: ExampleAttribute {
    
    public typealias PropertyIdentifier = Property.Identifier
    
    public private(set) var propertyIdentifier: String
    public private(set) var rawValue: String
    
    fileprivate init(_ identifier: PropertyIdentifier, _ value: String) {
        self.propertyIdentifier = identifier.rawValue
        self.rawValue = value.trimmed
        super.init(uuid: Self.namespace.uuid(enumerable: identifier, value))
    }
    
    public override var toString: String {
        "\(self.propertyIdentifier) | \(self.rawValue)"
    }
    
    public override var properties: [ExampleProperty] { [self] }
    
    fileprivate func setRawValueAndUUID(_ newValue: String) -> Void {
        self.rawValue = newValue.trimmed
        self.setUUID(self.namespace.uuid(enumerable: self.identifier, self.rawValue))
    }
    
    private var identifier: PropertyIdentifier {
        .init(rawValue: self.propertyIdentifier)!
    }
    
}

@Model @available(iOS 26, *)
public final class ExampleInputProperty: ExampleProperty, Randomizable {
    
    public static var random: ExampleInputProperty {
        .init(identifier: .random, value: .random)
    }
    
    public typealias InputIdentifier = Input.Identifier
    
    public private(set) var inputIdentifier: String
    
    private init(identifier: InputIdentifier, value: String) {
        self.inputIdentifier = identifier.rawValue
        super.init(.input, value)
    }
    
    public override var toString: String {
        "\(self.inputIdentifier) | \(self.rawValue)"
    }
    
    public var rawValueBinding: Binding<String> {
        .init(get: {
            self.rawValue
        }, set: { newValue in
            self.setRawValueAndUUID(newValue)
        })
    }
    
}

@Model @available(iOS 26, *)
public final class ExampleModeProperty: ExampleProperty, Randomizable {
    
    public static var random: ExampleModeProperty {
        .init(.random)
    }
    
    public enum ModeValue: Enumerable {
        
        case single, two, multi
        
        public var rawValue: String {
            switch self {
            case .single: return "Single-Player"
            case .two: return "Two-Player"
            case .multi: return "Multiplayer"
            }
        }
        
    }
    
    public init(_ value: ModeValue) {
        super.init(.mode, value.rawValue)
    }
    
}


// MARK: Platforms

@Model @available(iOS 26, *)
public final class ExamplePlatform: ExampleAttribute {
    
    @Relationship(inverse: \ExamplePlatformProperty.platforms)
    public private(set) var system: ExampleSystemProperty?
    
    @Relationship(inverse: \ExamplePlatformProperty.platforms)
    public private(set) var format: ExampleFormatProperty?
    
    public init(system: ExampleSystemProperty?, format: ExampleFormatProperty?) {
        self.system = system
        self.format = format
        let attribute = ExampleAttribute.AttributeIdentifier.platform
        let s: String = system?.toString ?? "system"
        let f: String = format?.toString ?? "format"
        super.init(uuid: Self.namespace.uuid(enumerable: attribute, s, f))
    }
    
    public override var properties: [ExampleProperty] {
        [self.system, self.format].compactMap(\.self)
    }
    
    public override var toString: String {
        let s = self.system?.rawValue ?? "system"
        let f = self.format?.rawValue ?? "format"
        return "\(s) | \(f)"
    }
    
}

@Model @available(iOS 26, *)
public class ExamplePlatformProperty: ExampleProperty {
    
    public var platforms: [ExamplePlatform]
    
    public override init(_ identifier: ExampleProperty.PropertyIdentifier, _ value: String) {
        self.platforms = .defaultValue
        super.init(identifier, value)
    }
    
}

@Model @available(iOS 26, *)
public final class ExampleSystemProperty: ExamplePlatformProperty {
    
    public static var random: ExampleSystemProperty { .init(.random) }
    
    public private(set) var systemIdentifier: String
    
    public init(_ registry: System.Registry) {
        self.systemIdentifier = registry.identifier.rawValue
        super.init(.system, registry.rawValue)
    }
    
}

@Model @available(iOS 26, *)
public final class ExampleFormatProperty: ExamplePlatformProperty {
    
    public static var random: ExampleFormatProperty { .init(.random) }
    
    public private(set) var formatIdentifier: String
    
    public init(_ registry: Format.Registry) {
        self.formatIdentifier = registry.identifier.rawValue
        super.init(.format, registry.rawValue)
    }
    
}


struct ExampleModels: View {
    
    @Environment(\.modelContext) public var modelContext
    
    public enum Models: Enumerable {
        case game, property, platform
    }
    
    var className: String {
        switch self.model {
        case .game:
            "Games"
        case .property:
            "Properties"
        case .platform:
            "Platforms"
        }
    }
    
    @Query private var games: [ExampleGame]
    @Query private var properties: [ExampleProperty]
    @Query private var platforms: [ExamplePlatform]
    
    @State var model: Models = .defaultValue
    
    var body: some View {
        NavigationStack {
            Form {
                switch self.model {
                case .game:
                    ExampleModelView(self.games)
                case .property:
                    ExampleModelView(self.properties)
                case .platform:
                    ExampleModelView(self.platforms)
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .bottomBar, content: {
                    
                    Picker(.defaultValue, selection: $model, content: {
                        ForEach(Models.cases) { model in
                            Text(model.rawValue).tag(model)
                        }
                    }).pickerStyle(.segmented)
                })
                
                //                ToolbarItem(placement: .topBarTrailing, content: {
                //                    Button("Add", action: createGameAndProperty)
                //                })
                
            }
            //            .onAppear {
            //                if games.isEmpty {
            //                    10.forEach(action: createGameAndProperty)
            //                }
            //            }
        }
    }
    
    //    private func createGameAndProperty() -> Void {
    //        let game = ExampleGame.random
    //
    //
    //        let attri
    //
    //        let property = ExampleProperty.random(.random)
    //
    //        game.insert(property)
    //
    //        modelContext.insert(game)
    //        modelContext.insert(property)
    //
    //        try? modelContext.save()
    //    }
    
    @ViewBuilder
    private func ExampleModelView(_ array: [ExampleBase]) -> some View {
        ExampleModelView(self.className, array)
    }
    
}

#Preview {
    
    let previewModelContainer: ModelContainer = {
        let container: ModelContainer = .forType("ExampleModels", types: [
            ExampleBase.self,
            ExampleGame.self, ExampleAttribute.self, ExampleProperty.self, ExampleInputProperty.self,
            ExampleModeProperty.self, ExampleSystemProperty.self, ExampleFormatProperty.self,
            ExamplePlatform.self, ExamplePlatformProperty.self
        ])
        
        
        /*
         create games
         create attributes
         // input, mode
         // or
         // platform 
         */
        
        return container
    }()
    
    ExampleModels()
        .modelContainer(previewModelContainer)
}
