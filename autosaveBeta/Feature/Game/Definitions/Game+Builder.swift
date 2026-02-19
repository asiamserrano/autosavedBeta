//
//  Game+Builder.swift
//  AutoSaveMock
//
//  Created by Asia Serrano on 2/6/26.
//

import Foundation
import Core

extension Game.Builder {
    
    private init(t: String, r: Date, s: Game.Status, b: Data? = nil, a: Date = .defaultValue) {
        self.titleStr = t.str
        self.release = r
        self.status = s
        self.boxart = b
        self.added = a
    }
    
    public init(title: String, release: Date, status: Game.Status, boxart: Data?, added: Date) {
        self.init(t: title, r: release, s: status, b: boxart, a: added)
    }
    
    public init(title: String, release: Date, status: Bool, boxart: Data?, added: Date) {
        self.init(t: title, r: release, s: .init(status), b: boxart, a: added)
    }
    
    public var status_bool: Bool {
        self.status.bool
    }
//
//    public init(observer: Game.Observer) {
//        self.init(observer.uuid, observer.title, observer.release, observer.status, observer.boxart, observer.added)
//    }
//    
//    public var modelBuilder: ModelKit.Model.Builder { .game(self) }
    
}

extension Game.Builder: Game.Object.Interface {
    
    public var title: String {
        self.titleStr.rawValue
    }
    
}
extension Game.Builder: ModelKit.Model.Builder.Interface {
    
    public typealias Model = Game

    public var compound: Compound {
        self.compoundForSwiftData
    }

//    public var id: String {
//        self.idForSwiftData
//    }
}

extension Game.Builder: Defaultable {
    
    public static var defaultValue: Self {
        .defaultValue(.defaultValue)
    }
    
    public static func defaultValue(_ status: Game.Status) -> Self {
        .init(t: .defaultValue, r: .defaultValue, s: status)
    }
    
}

extension Game.Builder: Randomizable {
    
    public static var random: Self {
        .random(.random)
    }
    
    public static func random(_ status: Game.Status) -> Self {
        .init(t: .random, r: .random, s: status)
    }
    
}
