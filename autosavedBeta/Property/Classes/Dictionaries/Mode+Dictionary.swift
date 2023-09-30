//
//  Mode+Dictionary.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation
import SwiftUI

public typealias MD = ModeDictionary

public class ModeDictionary: DictionaryProtocol {
    
    private static let all: [ModeEnum] = ModeEnum.all.sorted()
    
    public typealias Map = [ModeEnum: Bool]
    public typealias Values = [Bool]
    
    @Published private var map: Map = .init()
    
    public required init() { }
    
    public required init(_ ns: NSSet?) {
        if let nsset: NSSet = ns {
            let properties: [Property] = Property.filter(nsset, .mode)
            let builders: [ModeBuilder] = properties.map(ModeBuilder.init)
            self.map = .init(uniqueKeysWithValues: Self.all.map { ($0, builders.contains(.init($0))) })
        } else { self.map = .init() }
    }
    
    private var values: Values {
        Self.all.map { self.get($0) }
    }
    
    public var builders: [any BuilderProtocol] {
        Self.all.filter { self.get($0) }.map { ModeBuilder($0) }
    }
    
}

public extension MD {
    
    func get(_ m: ModeEnum) -> Bool {
        self.map[m] ?? false
    }
    
    func equals(_ other: MD) -> Bool {
        return self.values == other.values
    }
    
    func bind(_ m: ModeEnum) -> Binding<Bool> {
        Binding(get: {
            self.get(m)
        }, set: {
            self.map[m] = $0
        })
    }
    
}
