//
//  Game+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import SwiftUI

struct GameView: View, Equatable {
    
    static func == (lhs: GameView, rhs: GameView) -> Bool {
        lhs.uuid == rhs.uuid
    }

    @Environment(\.managedObjectContext) private var viewContext

    @State var editMode: EditMode = .active
    @State var title: String = .init()
    @State var release: Date = .today
    @State var image: Data? = nil

    @StateObject var dict: PropertyDictionary = .init()
    
    let uuid: UUID

    init() {
        self.uuid = .init()
    }

    init(_ game: Game) { self.init(.init(game)) }

    init(_ game: GameBuilder) {
        self.init()
        self._editMode = .init(wrappedValue: .inactive)
        self._title = .init(wrappedValue: game.title)
        self._release = .init(wrappedValue: game.release)
        self._image = .init(wrappedValue: game.image)
        self._dict = .init(wrappedValue: .init(game))
    }

    private var editing: Bool { self.editMode.isEditing }

    private var inputEnums: [InputEnum] {
        InputEnum.all.filter { $0 == .series ? self.editing : true }
    }

    private var series: String? {
        self.dict.getValues(.series).first
    }

    var body: some View {
        Form {
            Text("my uuid: \(self.uuid.uuidString)")
            Section {
                if self.editing {
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

            ForEach(self.inputEnums, id:\.self) { InputsView($0, $editMode, dict) }
            ModesView($editMode, dict)
            PlatformsView($editMode, dict)

        }
        .navigationBarBackButtonHidden(self.editing)
        .environment(\.editMode, $editMode)
        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: self.toggle, label: {
                    Text("Cancel")
                }).hide(!self.editing)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: self.toggle, label: {
                    Text(self.editing ? "Done" : "Edit")
                })
            }
        }

    }


    private func toggle() -> Void {
        self.editMode = self.editing ? .inactive : .active
    }

//    @ViewBuilder
//    public func MockedView(_ builder: PlatformBuilder) -> some View {
//        VStack(alignment: .leading) {
//            FormView("property", builder.propertyEnum.key)
//            FormView("platform", builder.platform.child.key)
//            FormView("medium", builder.format.child.key)
//            FormView("format", builder.format.key)
//
//        }
//    }
//
//    @ViewBuilder
//    public func ModeView(_ builder: ModeBuilder) -> some View {
//        VStack(alignment: .leading) {
//            FormView("property", builder.propertyEnum.key)
//            FormView("mode", builder.mode.key)
//            FormView("tertiary", nil)
//            FormView("value", nil)
//        }
//    }

}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            GameView()
//        }
//    }
//}
