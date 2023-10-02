//
//  Property+Set.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import Foundation

public class PropertyDictionary: ObservableObject, Equatable {
    
    @Published var nsset: NSSet = .init()
    
    public init() { }
    
    public init(_ arr: [PropertyBuilder]) {
        self.nsset = .init(arr)
    }
    
    public convenience init(_ game: Game) {
        self.init(GameBuilder(game))
    }
    
    public convenience init(_ game: GameBuilder) {
        self.init(game.builders)
    }
    
}

extension PropertyDictionary {
    
    public func update(_ game: GameBuilder) -> Void {
        self.nsset = .init(game.builders)
    }
    
    private func insert(_ obj: PropertyBuilder) -> Void {
        self.nsset = .init(self.allObjects + [obj])
    }
    
    private func remove(_ obj: PropertyBuilder) -> Void {
        self.nsset = .init(self.allObjects.filter(obj.doesNotEqual))
    }
    
    private func filter(_ t: TypeEnum) -> [PropertyBuilder] {
        self.allObjects.filter(t.equals)
    }
    
    public var allObjects: [PropertyBuilder] {
        self.nsset.allObjects.map { $0 as! PropertyBuilder }
    }
    
    private func hash(_ ele: PropertyBuilder) -> Int {
        var hasher: Hasher = .init()
        hasher.combine(ele.get(.primary))
        hasher.combine(ele.get(.secondary))
        hasher.combine(ele.get(.tertiary))
        hasher.combine(ele.get(.value))
        return hasher.finalize()
    }
    
    private var hashed: [Int] { self.allObjects.map(hash).sorted() }
    
    public static func == (lhs: PropertyDictionary, rhs: PropertyDictionary) -> Bool {
        lhs.hashed == rhs.hashed
    }
    
}

extension PropertyDictionary: PlatformDictionaryProtocol {
    
    public var platforms: [PlatformEnum: [FormatEnum]] {
        let builders: [PlatformBuilder] = self.filter(.platform).map { $0 as! PlatformBuilder }
        return .init(uniqueKeysWithValues: builders.map { builder in
            let plat: PlatformEnum = builder.platformEnum
            let formats: [FormatEnum] = builders.filter { $0.tuple.0 == plat }.map { $0.tuple.1 }
            return (plat, formats)
        })
    }
    
    public func removePlatform(_ index: Int) -> Void {
        let platform: PlatformEnum = self.platformKeys[index]
        self.getFormats(platform).forEach {
            self.remove(PlatformBuilder(platform, $0))
        }
    }
    
    public func removeFormat(_ key: PlatformEnum, _ index: Int) {
        self.remove(PlatformBuilder(key, self.getFormats(key)[index]))
    }
    
    public func insertPlatform(_ p: PlatformEnum, _ f: [FormatEnum]) {
        if let index: Int = self.platformKeys.firstIndex(of: p) {
            self.removePlatform(index)
        }
        f.forEach { self.insert(PlatformBuilder(p, $0)) }
    }
    
}

extension PropertyDictionary: InputDictionaryProtocol {
    
    public typealias Map = [InputEnum : [String: String]]
                            
    public var inputs: [InputEnum : [String: String]] {
        self.filter(.input).map { $0 as! InputBuilder }.reduce(into: Map()) { dict, builder in
            let input: InputEnum = builder.inputEnum
            var strings: [String: String] = dict[input] ?? .init()
            strings[builder.tuple.0] = builder.tuple.1
            dict[input] = strings
        }
    }
    
    public func removeInput(_ index: Int) {
        let input: InputEnum = self.inputKeys[index]
        self.getValues(input).forEach {
            self.remove(InputBuilder(input, $0))
        }
    }
    
    public func removeInput(_ key: InputEnum, _ index: Int) {
        self.remove(InputBuilder(key, self.getValues(key)[index]))
    }
    
    public func insertInput(_ i: InputEnum, _ s: String) {
        self.remove(i, self.inputs[i]?[s.canonicalized])
        self.remove(i)
        self.insert(InputBuilder(i, s))
    }
    
    private func remove(_ i: InputEnum, _ str: String?) {
        if let val: String = str {
            self.remove(InputBuilder(i, val))
        }
    }
    
    private func remove(_ i: InputEnum) {
        if i.isSingular, let index: Int = self.inputKeys.firstIndex(of: i) {
            self.removeInput(index)
        }
    }
    
}

extension PropertyDictionary: ModeDictionaryProtocol {
    
    public var modes: [ModeEnum] {
        self.filter(.mode).map { ($0 as! ModeBuilder).modeEnum }
    }
    
    public func insertMode(_ m: ModeEnum) {
        if !self.contains(m) { self.insert(ModeBuilder(m)) }
    }
    
    public func removeMode(_ m: ModeEnum) {
        self.remove(ModeBuilder(m))
    }
    
}
