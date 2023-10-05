//
//  FilteredGamesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/4/23.
//

import SwiftUI
import CoreData

struct FilteredGamesView<T: NSManagedObject, Content: View>: StandardViewProtocol {
    
    public enum ContentEnum {
        case single((T) -> Content)
        case array(([T]) -> Content)
    }
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    @FetchRequest var fetchRequest: FetchedResults<T>
    
//    @State var alertConfirm: Bool = false
//    @State var alertComplete: Bool = false
//
//    @State var selectedGame: Game? = nil
//    @State var deletedGame: String? = nil
    
//    let content: (T) -> Content
    let content: ContentEnum
    
//    private static func create(_ str: String, _ initialPredicate: NSPredicate?) -> NSPredicate? {
//        let canon: String = str.canonicalized
//        let count: Int = canon.count
//
//        var newPredicate: NSPredicate? {
//            switch count {
//            case 0: return nil
//            case 1: return .init(.raw, canon, .begin)
//            default: return .init(.raw, canon, .contain)
//            }
//        }
//
//        if let initPred: NSPredicate = initialPredicate {
//            if let newPred: NSPredicate = newPredicate {
//                return NSCompoundPredicate(andPredicateWithSubpredicates: [initPred, newPred])
//            } else { return initPred }
//        } else { return nil }
//
//    }
    
//    init(_ str: String, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
//        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
//        self.content = content
//    }
    
    init(_ str: String, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
//        self.content = content
        self.content = .single(content)
    }
    
    init(_ str: String, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping ([T]) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
//        self.content = content
        self.content = .array(content)
    }
    
    var body: some View {
        switch self.content {
        case .single(let con): SingleView(single: con)
        case .array(let con): ArrayView(array: con)
        }
    }
    
    @ViewBuilder
    private func SingleView(@ViewBuilder single: @escaping (T) -> Content) -> some View  {
//        List {
            ForEach(self.fetchRequest, id: \.self) { item in
                single(item)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Delete") {
                            self.viewContext.remove(item)
                        }.tint(.red)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        let destination: String = menuEnum == .library ? "Wishlist" : "Library"
                        Button("Move to \(destination)") {
                            if let game: Game = item as? Game {
                                let builder: GameBuilder = .init(game).withStatus(!game.status)
                                let _: Game = game.update(self.viewContext, builder)
                            }
                        }.tint(.green)
                    }
            }
//        }
    }
    
    @ViewBuilder
    private func ArrayView(@ViewBuilder array: @escaping ([T]) -> Content) -> some View  {
        array(self.fetchRequest.map { $0 })
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

