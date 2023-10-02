//
//  GameModifiable+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/1/23.
//

import Foundation
import SwiftUI

public protocol GameModifiableProtocol: CloseableProtocol {
    
    var dict: PropertyDictionary { get }
    var editMode: EditMode { get set }
    var old: GameBuilder? { get set }

    var viewContext: Context { get }
    var new: GameBuilder { get }
    var status: Bool { get }
    var title: String { get }
    var buttonName: String { get }
    
    func toggleEdit() -> Void
    func toggleAlert(_ str: String, _ successful: Bool) -> Void
    
    func buttonAction() -> Void
    
}

extension GameModifiableProtocol {
    
    var editing: Bool { self.editMode.isEditing }
    var adding: Bool { self.old == nil }
    
    var series: String? {
        self.dict.getValues(.series).first
    }

    var inputEnums: [InputEnum] {
        InputEnum.all.filter { $0 == .series ? self.editing : true }
    }
    
    var buttonName: String { self.editing ? "Done" : "Edit" }
    
    var isDoneDisabled: Bool {
        if self.editing {
            let isTitleEmpty: Bool = self.title.isEmpty
            if let builder: GameBuilder = self.old {
                return isTitleEmpty || self.new.equals(builder)
            } else { return isTitleEmpty }
        } else { return false }
    }
    
    func buttonAction() -> Void {
        self.editing ? self.done() : self.edit()
    }
    
    private func done() -> Void {
        
        var success: Bool = self.editing
        
        func fetchGame(_ b: GameBuilder) -> Game? {
            self.viewContext.fetchGame(b)
        }
        
        var alertString: String {
            if let builder: GameBuilder = self.old, let oldGame: Game = fetchGame(builder) {
                // editing an existing game
                if let newGame: Game = fetchGame(self.new) {
                    // new builder found a game
                    if newGame.uuid == oldGame.uuid {
                        // new builder has same name/date, need to update old game - UPDATE
                        let updated: Game = oldGame.update(self.viewContext, self.new)
                        return updated.alertString
//                        return "updated w/ found game: \(updated.alertString)"
                    } else {
                        // new builder trying to edit to name/date that already exists - ERROR
                        success = false
                        return newGame.alertString
//                        return "error - trying to update w/game that exists: \(newGame.alertString)"
                    }
                } else {
                    // new builder did not find a game - update the old one - UPDATE
                    let updated: Game = oldGame.update(self.viewContext, self.new)
                    return updated.alertString
//                    return "updated w/out found game: \(updated.alertString)"
                }
            } else {
                // adding a new game
                if let newGame: Game = fetchGame(self.new) {
                    // game was found - should not add - ERROR
                    success = false
                    return newGame.alertString
//                    return "error - trying to create game that exists: \(newGame.alertString)"
                } else {
                    // not game was found = should create - CREATE
                    let created: Game = self.new.build(self.viewContext)
                    return created.alertString
//                    return "created game: \(created.alertString)"
                }
            }
        }
        
        self.toggleAlert(alertString, success)
    }
    
    private func edit() -> Void {
        self.toggleEdit()
    }
    
}
