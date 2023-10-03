////
////  Game+View.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////
//
//import SwiftUI
//
//struct GameView: GameModifiableProtocol {
//    
//    @Environment(\.managedObjectContext) public var viewContext
//    @Environment(\.presentationMode) public var presentationMode
//
//    @StateObject var dict: PropertyDictionary = .init()
//    @StateObject var alertObj: AlertObject = .init()
//
//    @State var editMode: EditMode = .active
//    @State var title: String = .init()
//    @State var release: Date = .today
//    @State var image: Data? = nil
//    
//    @State var close: Bool = false
//    
//    @State var old: GameBuilder? = nil
//    
//    let status: Bool
//    
//    init(_ builder: GameBuilder? = nil, _ s: Bool = true) {
//        self.status = s
//        self._old = .init(wrappedValue: builder)
//    }
//
//    init(_ game: Game) { self.init(.init(game)) }
//
//    init(_ game: GameBuilder) {
//        self.init(game, game.owned)
//        self._editMode = .init(wrappedValue: .inactive)
//        self._title = .init(wrappedValue: game.title)
//        self._release = .init(wrappedValue: game.release)
//        self._image = .init(wrappedValue: game.image)
//        self._dict = .init(wrappedValue: .init(game))
//    }
//
//    var body: some View {
//        Form {
//            if let b: GameBuilder = self.old {
//                FormView("properties count", b.builders.count)
//            }
//            Section {
//                if self.editing {
//                    ClearableTextField($title)
//                    DatePicker(selection: $release, displayedComponents: .date) {
//                        Text("Release Date")
//                    }
//                } else {
//                    FormView("Title", self.title)
//                    FormView("Release", self.release.long)
//                    if let s: String = self.series {
//                        FormView(InputEnum.series.value, s)
//                    }
//                }
//            }
//
//            ForEach(self.inputEnums, id:\.self) { InputsView($0, $editMode, dict) }
////            ModesView($editMode, dict)
////            PlatformsView($editMode, dict)
//
//        }
//        .onChange(of: self.close, perform: self.closed)
//        .alert(isPresented: self.$alertObj.show) { self.alertObj.alert }
//        .navigationBarBackButtonHidden(self.editing)
//        .environment(\.editMode, $editMode)
//        .toolbar {
//
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button("Cancel", action: self.cancel).hide(!self.editing)
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(self.buttonName, action: self.buttonAction)
//                    .disabled(self.isDoneDisabled)
//            }
//        }
//
//    }
//    
//}
//
//extension GameView {
//    
//    var new: GameBuilder {
//        .init()
//        .withTitle(self.title)
//        .withRelease(self.release)
//        .withStatus(self.status)
//        .withImage(self.image)
//        .setProperties(self.dict)
//    }
//    
//    func toggleEdit() -> Void {
//        self.editMode = self.editing ? .inactive : .active
//    }
//    
//    func toggleAlert(_ str: String, _ successful: Bool) -> Void {
//        self.alertObj.toggle(str, .build(successful, self.adding))
//        self.close = successful
//    }
//    
//    func cancel() -> Void {
//        if let game: GameBuilder = self.old {
//            self.title = game.title
//            self.release = game.release
//            self.image = game.image
//            self.dict.update(game)
//            self.toggleEdit()
//        } else {
//            self.close = true
//        }
//    }
//    
//}
