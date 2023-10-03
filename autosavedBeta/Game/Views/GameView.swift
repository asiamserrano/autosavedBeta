//
//  GameView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI

struct GameView: GameViewProtocol {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewObject: ViewObject
    
    @State var editMode: EditMode = .active
    @State var close: Bool = false
    
    @StateObject var dictionary: PropertyDictionary = .init()
    
    @State var title: String = .empty
    @State var release: Date = .today
    @State var image: Data? = nil
    
    @State var alertObject: AlertObject = .init()
    
    let game: Game?
    let status: Bool
    
    init(_ g: Game) {
        self.game = g
        self.status = g.status
        self._title = .init(wrappedValue: g.title)
        self._release = .init(wrappedValue: g.release)
        self._image = .init(wrappedValue: g.image)
        self._dictionary = .init(wrappedValue: .init(g))
        self._editMode = .init(wrappedValue: .inactive)
    }
    
    init(_ s: Bool = true) {
        self.game = nil
        self.status = s
    }
    
    var body: some View {
        Form {
            FormView("show alert?", self.alertObject.show)
            Section {
                if self.isEditing {
                    ClearableTextField($title)
                    DatePicker(selection: $release, displayedComponents: .date) {
                        Text("Release Date")
                    }
                } else {
                    FormView("Title", self.title)
                    FormView("Release", self.release.long)
                    if let s: String = self.series {
                        FormView(InputEnum.series.value, s)
                    }
                }
            }
            
            ForEach(self.inputEnums, id:\.self) { InputsView($0, $editMode, self.dictionary) }
            //            ModesView($editMode, dict)
            //            PlatformsView($editMode, dict)
            
        }
        .onChange(of: self.close, perform: self.closed)
        .alert(isPresented: self.$alertObject.show) { self.alertObject.alert }
        .navigationBarBackButtonHidden(self.isEditing)
        .environment(\.editMode, $editMode)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel", action: self.cancel).hide(!self.isEditing)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(self.buttonName, action: self.buttonAction)
                    .disabled(self.isDoneDisabled)
            }
        }
    }
    
}

extension GameView {
    
    func toggle() -> Void {
        self.editMode = self.isEditing ? .inactive : .active
    }
    
    func toggle(_ str: String, _ successful: Bool) -> Void {
        self.alertObject = .init(str, .build(successful, self.isNew))
        self.close = successful
    }
    
    func cancel() -> Void {
        if let game: GameBuilder = self.oldBuilder {
            self.title = game.title
            self.release = game.release
            self.image = game.image
            self.dictionary.update(game)
            self.toggle()
        } else {
            self.closed(true)
        }
    }
    
}
