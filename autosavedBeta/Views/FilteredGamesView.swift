//
//  FilteredGamesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/4/23.
//

import SwiftUI
import CoreData

struct FilteredGamesView<T: NSManagedObject, Content: View>: View {
    
    @State var alertConfirm: Bool = false
    @State var alertComplete: Bool = false
    @State var selectedGame: Game? = nil
    @State var deletedGame: String? = nil
    
    let content: (T) -> Content
    var games: FetchedResults<T>
    
    init(_ items: FetchedResults<T>, @ViewBuilder content: @escaping (T) -> Content) {
        self.games = items
        self.content = content
    }
    
    var body: some View {
        ForEach(self.games, id: \.self) { item in
            self.content(item)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button("Delete") {
                        print("shrimp")
//                        self.selected = item as? Game
                    }.tint(.red)
                }
        }
    }
}


//    public func ConfirmDelete() -> Alert {
//        let t: Text = Text("Delete Game?")
//        let m: Text = Text("Are you sure you want to delete \(self.selected!.alertString)?")
//        let prim: Alert.Button = .cancel(Text("Cancel"), action: { self.selected = nil })
//        let sec: Alert.Button = .destructive(Text("Confirm"), action: {
//            self.viewContext.remove(self.selected!)
//            self.alertComplete.toggle()
//        })
//        return Alert(title: t, message: m, primaryButton: prim, secondaryButton: sec)
//    }

//        .onChange(of: self.selected, perform: { self.alertConfirm = $0 != nil })
//        .alert(isPresented: $alertComplete, content: {
//            Alert(title: Text("\(self.selected!.alertString) has been deleted."), dismissButton: .default(Text("OK"), action: {
//                self.selected = nil
//            }))
//        })

