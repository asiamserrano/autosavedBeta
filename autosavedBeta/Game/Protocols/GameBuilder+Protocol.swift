//
//  GameBuilder+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import Foundation

public protocol GameBuilderProtocol: IdentifiableProtocol {
    
    var uuid: UUID { get }
    var add: Date { get }
    var dictionary: PropertyDictionary { get set }
    var title: String { get set }
    var release: Date { get set }
    var owned: Bool { get set }
    var image: Data? { get set }
    
}

extension GameBuilderProtocol {
    
    public var builders: [PropertyBuilder] { self.dictionary.allObjects }

    public func equals(_ other: Self) -> Bool {
        self.title.trimmed == other.title.trimmed
        && self.release.dashless == other.release.dashless
        && self.image == other.image
        && self.dictionary == other.dictionary
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.title.canonicalized)
        hasher.combine(self.release)
    }
    
    @discardableResult
    public func build(_ con: Context) -> Game {
        .init(context: con).update(con, self)
    }
    
//    @discardableResult
//    public func nsset(_ con: Context, _ game: Game) -> NSSet {
//        con.nsset(<#T##builder: GameBuilderProtocol##GameBuilderProtocol#>, <#T##game: Game##Game#>)
////        .init(self.builders.map(con.fetchProperty))//con.createNSSet(self, builder)
//    }
    
}
