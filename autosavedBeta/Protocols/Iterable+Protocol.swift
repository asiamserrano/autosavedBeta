//
//  Iterable+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public protocol IterableProtocol: IdentifiableProtocol, CaseIterable, Comparable {

    var key: String { get }
    var value: String { get }

    static var all: [Self] { get }

}

public extension IterableProtocol {

    static func < (lhs:Self, rhs: Self) -> Bool { lhs.value < rhs.value }

    static var all: [Self] { self.allCases.sorted(by: { $0.index < $1.index }) }
    
    static var random: Self { self.all.randomElement()! }

    init?(_ str: String?) {
        if let found: Self = Self.all.first(where: str.equals) {
            self = found
        } else { return nil }
    }
    
    private var index: Int { Int(String(describing: Self.allCases.firstIndex(of: self)!))! }
    
    var defaultValue: String { self.key.capitalized }
    var key: String { String(describing: self) }
    var value: String { self.defaultValue }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.className)
        hasher.combine(self.key)
    }
    
    func equals(_ str: String?) -> Bool {
        self.key == str || self.value == str
    }
    
    func iterateToNext() -> Self {
        let index: Int = Self.all.count - 1 == self.index ? 0 : self.index + 1
        return Self.all[index]
    }

}
