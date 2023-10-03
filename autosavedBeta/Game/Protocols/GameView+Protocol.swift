//
//  GameView+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import Foundation
import SwiftUI

public protocol GameViewProtocol: CloseableProtocol {

    var viewContext: Context { get }
    var dictionary: PropertyDictionary { get }
    var game: Game? { get }
    var status: Bool { get }
    
    var editMode: EditMode { get set }
    var title: String { get set }
    var release: Date { get set }
    var image: Data? { get set }
    
    
    func toggle() -> Void
    func toggle(_ str: String, _ successful: Bool) -> Void
//    func toggleAlert(_ str: String, _ successful: Bool) -> Void
//
//    func buttonAction() -> Void
    
}

extension GameViewProtocol {
    
    var isEditing: Bool { self.editMode.isEditing }
    var isNew: Bool { self.game == nil }
    var series: String? { self.dictionary.getValues(.series).first }
    var inputEnums: [InputEnum] { InputEnum.filterForEditing(self.isEditing) }
    
    var newBuilder: GameBuilder {
        .init()
        .withTitle(self.title)
        .withRelease(self.release)
        .withStatus(self.status)
        .withImage(self.image)
        .withDictionary(self.dictionary)
    }
    
    var oldBuilder: GameBuilder? {
        if let old: Game = self.game {
            return .init(old)
        } else { return nil }
    }
    
    var isDoneDisabled: Bool {
        if self.isEditing {
            let isTitleEmpty: Bool = self.title.isEmpty
            if let old: GameBuilder = self.oldBuilder {
                return isTitleEmpty || self.newBuilder.equals(old)
            } else { return isTitleEmpty }
        } else { return false }
    }

    var buttonName: String { self.isEditing ? "Done" : "Edit" }

    func buttonAction() -> Void {
        self.isEditing ? self.done() : self.edit()
    }
    
    private func fetchGame(_ b: GameBuilder) -> Game? {
        self.viewContext.fetchGame(b)
    }
    
    private func toggle(_ oldGame: Game) -> Void {
        let updated: Game = oldGame.update(self.viewContext, self.newBuilder)
        toggle(updated.alertString, true)
    }
    
    private func update(_ oldGame: Game) -> Void {
        if let newGame: Game = fetchGame(self.newBuilder), newGame.uuid != oldGame.uuid {
            toggle(newGame.alertString, false)
        } else { toggle(oldGame) }
    }
    
    private func create() -> Void {
        if let newGame: Game = fetchGame(self.newBuilder) {
            toggle(newGame.alertString, false)
        } else {
            let created: Game = self.newBuilder.build(self.viewContext)
            toggle(created.alertString, true)
        }
    }
    
    private func done() -> Void {
        if let oldGame: Game = self.game { update(oldGame) }
        else { create() }
    }
    
//    if let oldGame: Game = self.game {
//        if let newGame: Game = fetchGame(self.newBuilder) {
//            if newGame.uuid == oldGame.uuid {
//                let updated: Game = oldGame.update(self.viewContext, self.newBuilder)
//                return updated.alertString
//            } else {
//                success = false
//                return newGame.alertString
//            }
//        } else {
//            let updated: Game = oldGame.update(self.viewContext, self.new)
//            return updated.alertString
//        }
//    }
    
//    private func doneOld() -> Void {
//
//        var success: Bool = self.isEditing
//
//        func fetchGame(_ b: GameBuilder) -> Game? {
//            self.viewContext.fetchGame(b)
//        }
//
//        var alertString: String {
//            if let oldGame: Game = self.game {
//                if let newGame: Game = fetchGame(self.newBuilder) {
//                    if newGame.uuid == oldGame.uuid {
//                        let updated: Game = oldGame.update(self.viewContext, self.newBuilder)
//                        return updated.alertString
//                    } else {
//                        success = false
//                        return newGame.alertString
//                    }
//                } else {
//                    let updated: Game = oldGame.update(self.viewContext, self.new)
//                    return updated.alertString
//                }
//            } else {
//                // adding a new game
//                if let newGame: Game = fetchGame(self.new) {
//                    // game was found - should not add - ERROR
//                    success = false
//                    return newGame.alertString
////                    return "error - trying to create game that exists: \(newGame.alertString)"
//                } else {
//                    // not game was found = should create - CREATE
//                    let created: Game = self.new.build(self.viewContext)
//                    return created.alertString
////                    return "created game: \(created.alertString)"
//                }
//            }
//        }
//
//        self.toggle(alertString, success)
//    }

    private func edit() -> Void {
        self.toggle()
    }
    
}
