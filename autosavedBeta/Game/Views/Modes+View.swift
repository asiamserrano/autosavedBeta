//
//  Modes+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import SwiftUI

struct ModesView: View {

    @Binding var editMode: EditMode
    @ObservedObject var dict: PropertyDictionary

    init(_ edit: Binding<EditMode>, _ d: PropertyDictionary) {
        self._editMode = edit
        self.dict = d
    }
    
    private var editing: Bool { self.editMode.isEditing }
    
    private func contains(_ m: ModeEnum) -> Bool {
        self.dict.contains(m)
    }
    
    private func createBinding(_ m: ModeEnum) -> Binding<Bool> {
        Binding(get: { self.contains(m) }, set: {
            $0 ? self.dict.insertMode(m) : self.dict.removeMode(m)
        })
    }

    var body: some View {
        Section(TypeEnum.mode.display) {
            ForEach(ModeEnum.all) { mode in
                let val: String = mode.value
                if self.editing { Toggle(val, isOn: createBinding(mode)) }
                else if self.contains(mode) {  Text(val) }
            }
        }
    }
    
}
