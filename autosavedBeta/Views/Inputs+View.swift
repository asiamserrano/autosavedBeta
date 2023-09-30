////
////  Inputs+View.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////
//
//import SwiftUI
//struct InputsView: View {
//    
////    @ObservedObject var dict: StringDictionary
//    
//    @ObservedObject var inputDict: InputDictionary
//    @StateObject var stringDict: StringDictionary
//
//    @Binding var editMode: EditMode
//
//    private var editing: Bool { self.editMode.isEditing }
//
//    let input: InputEnum
//    let uuid: UUID = .init()
//    
//    init(_ edit: Binding<EditMode>, _ input: InputEnum, _ d: InputDictionary) {
//        self.inputDict = d
//        self.input = input
//        self._editMode = edit
//        self._stringDict = .init(d.get(input))
//    }
//
//    private var items: [String] {
//        self.stringDict.values
//    }
//
//    var body: some View {
//        let bool: Bool = !self.editing
//        Section(content: {
//            List {
//                ForEach(self.items, id:\.self) {
//                    Text($0)
//                }.onDelete(perform: self.delete)
//            }.id(self.uuid)
//        }, header: {
//            NavigationLink(destination: {
//                AddInputView(self.input, self.inputDict)
//                    .navigationBarBackButtonHidden(true)
//            }, label: {
//                HStack(alignment: .center, spacing: 5) {
//                    Text(self.input.value).font(.footnote)
//                    IconView("chevron.right", .blue, 10).hide(bool)
//                }
//            })
//            .disabled(bool)
//            .foregroundColor(bool ? .gray : .blue)
//        })
//    }
//    
//    private func delete(_ off: IndexSet) -> Void {
//        off.forEach { self.inputDict.put(self.input, self.stringDict.remove(self.items[$0])) }
//    }
//
//}
//
//
////struct InputsView_Previews: PreviewProvider {
////    static var previews: some View {
////        InputView()
////    }
////}
