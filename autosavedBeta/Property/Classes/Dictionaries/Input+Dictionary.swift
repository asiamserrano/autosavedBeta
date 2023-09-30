//
//  Input+Dictionary.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public typealias ID = InputDictionary

public class InputDictionary: DictionaryProtocol {
    
    public typealias Map = [InputEnum: SD]
    public typealias Keys = [InputEnum]
    
    @Published private var map: Map = .init()
    
    public required init() { }
    
    public required convenience init(_ ns: NSSet?) {
        self.init()
        if let nsset: NSSet = ns {
            let properties: [Property] = Property.filter(nsset, .input)
            let builders: [InputBuilder] = properties.map(InputBuilder.init)
            InputEnum.all.forEach { input in
                let arr: [String] = builders.filter { $0.inputEnum == input }.map { $0.value }
                if !arr.isEmpty { self.map[input] = .init(arr) }
            }
        }
    }
    
    public var keys: Keys {
        self.map.keys.sorted()
    }
    
    public var builders: [any BuilderProtocol] {
        self.keys.flatMap { self.get($0).createBuilders($0) }
    }
    
}

public extension ID {
    
    func put(_ i: InputEnum, _ str: String?) -> Void {
        if let string: String = str {
            self.map[i] = i.isSingular ? .init(string) : self.get(i).put(string)
        }
    }
    
    func get(_ i: InputEnum) -> SD {
        self.map[i] ?? .init()
    }
    
    func equals(_ o: ID, _ hash: HashEnum) -> Bool {
        self.keys == o.keys ? self.keys.allSatisfy {
            self.get($0).equals(o.get($0), hash)
        } : false
    }
    
}
