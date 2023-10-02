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
//    let uuid: UUID = .init()
    
    init(_ input: InputEnum, _ edit: Binding<EditMode>, _ d: PropertyDictionary) {
        self.input = input
        self.dict = d
        self._editMode = edit
    }

//    private var items: [String] {
//        self.set.inputs(self.input).map { $0.value }
//    }

    var body: some View {
        let bool: Bool = !self.editing
        Section(content: {
            List {
                ForEach(self.dict.getValues(self.input), id:\.self) {
                    Text($0).tag($0)
                }.onDelete(perform: self.delete)
            }
//            .id(self.uuid)
        }, header: {
            NavigationLink(destination: {
                AddInputView(self.input, dict)
                    .navigationBarBackButtonHidden(true)
            }, label: {
                HStack(alignment: .center, spacing: 5) {
                    Text(self.input.value).font(.footnote)
                    IconView("chevron.right", .blue, 10).hide(bool)
                }
            })
            .disabled(bool)
            .foregroundColor(bool ? .gray : .blue)
        })
    }
    
    private func delete(_ off: IndexSet) -> Void {
        off.forEach {
            self.dict.removeInput(self.input, $0)
//            self.set.remove(InputBuilder(self.input, self.items[$0]))
        }
    }

}


//struct InputsView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputView()
//    }
//}
