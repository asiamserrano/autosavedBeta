//
//  TestView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/1/23.
//

import SwiftUI

struct TestView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.customAlertObject) var alertObject

    @State var editMode: EditMode = .inactive
    @State var show: Bool = false
    @State var message: String = .empty
    
    init() { }

    private var editing: Bool { self.editMode.isEditing }

    var body: some View {
        Form {
            Section {
                if self.editing {
                    ClearableTextField($message)
                } else {
                    FormView("Message", self.message)
                }
            }
            
            FormView("my show bool", self.show)


        }
        .alert(isPresented: $show) {
            Alert(title: Text(self.message))
        }
        .navigationBarBackButtonHidden(self.editing)
        .environment(\.editMode, $editMode)
        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: self.toggle, label: {
                    Text("Cancel")
                })
                .hide(!self.editing)
               
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: self.toggle, label: {
                    Text(self.editing ? "Done" : "Edit")
                }).disabled( self.editing ? self.message.isEmpty : false )
             
            }
        }

    }

    private func toggle() -> Void {
        if self.editing {
            
           
            
            
//            self.message = "toggled"
//            self.alertObject.toggle(self.message)
        }
        
        self.editMode = self.editing ? .inactive : .active
    }

}


struct TestView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            TestView()
//                .environment(\.customAlertObject, CustomAlertKey.defaultValue)
        }
    }
}
