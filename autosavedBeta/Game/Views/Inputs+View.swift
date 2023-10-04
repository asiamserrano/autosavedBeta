//
//  Inputs+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//


import SwiftUI

struct InputsView: View {
    
    @Binding var editMode: EditMode
    @ObservedObject var dict: PropertyDictionary

    private var editing: Bool { self.editMode.isEditing }

    let input: InputEnum
    
    init(_ input: InputEnum, _ edit: Binding<EditMode>, _ d: PropertyDictionary) {
        self.input = input
        self.dict = d
        self._editMode = edit
    }
    
    var body: some View {
        let bool: Bool = !self.editing
        Section(content: {
            List {
                ForEach(self.dict.getValues(self.input), id:\.self) {
                    Text($0).tag($0)
                }.onDelete(perform: self.delete)
            }
        }, header: {
            NavigationLink(destination: {
                AddInputView(self.input, dict)
                    .navigationBarBackButtonHidden(true)
            }, label: {
                HStack(alignment: .center, spacing: 8) {
                    Text(self.input.display).font(.footnote)
                    IconView("plus.circle.fill", .green, 18).hide(bool)
                }
            })
            .disabled(bool)
            .foregroundColor(bool ? .gray : .blue)
        })
    }
    
    private func delete(_ off: IndexSet) -> Void {
        off.forEach { self.dict.removeInput(self.input, $0) }
    }

}

