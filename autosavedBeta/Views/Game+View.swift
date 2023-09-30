//
//  Game+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import SwiftUI

struct GameView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var editMode: EditMode = .active
    @State var title: String = .init()
    @State var release: Date = .today
    @State var image: Data? = nil

    @StateObject var inputs: InputDictionary = .init()
    @StateObject var modes: ModeDictionary = .init()
    @StateObject var platforms: PlatformDictionary = .init()
    
//    @ObservedObject var properties: PropertyDictionary

    init() { }

    init(_ game: Game) { self.init(.init(game)) }

    init(_ game: GameBuilder) {
        self.editMode = .inactive
        self.title = game.title
        self.release = game.release
        self.image = game.image
        self.properties = game.properties
    }

    private var editing: Bool { self.editMode.isEditing }

    private var inputEnums: [InputEnum] {
        InputEnum.all.filter { $0 == .series ? self.editing : true }
    }



    private var series: String? {
        let sd: StringDictionary = self.properties.input.get(.series)
        if let key: String = sd.keys.first, let string: String = sd.get(key) {
            return string
        } else { return nil }
    }

    var body: some View {
        Form {
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

            ForEach(self.inputEnums, id:\.self) { InputsView($editMode, $0, self.inputs) }

//            ModesView($editMode, self.modes)
//
//
//            PlatformView($editMode, self.properties)

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
