//
//  FilteredGamesListView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import SwiftUI

struct FilteredGamesListView<T: Game, Content: View>: StandardViewProtocol, Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.search.equals(rhs.search)
    }
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    
    @State var search: String = .empty
//    @State var uuid: UUID = .init()
    
//    @State var sortDescriptors: [SortDesc] = .name
    
    let content: (T) -> Content
    
    init(@ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
    }
    
    var sortDescriptors: [SortDesc] {
        switch self.sortEnum {
        case .name: return .nameSortDesc(self.ascending)
        case .release: return .releaseSortDesc(self.ascending)
        }
    }
    
    var predicate: NSPredicate? {
        let canon: String = self.search.canonicalized
        let count: Int = canon.count
        switch count {
        case 0: return nil
        case 1: return .init(.raw, canon, .begin)
        default: return .init(.raw, canon, .contain)
        }
    }
    
    var allData: [T] {
        self.viewContext.fetchGames(self.predicate, self.sortDescriptors) as! [T]
    }
    
    var body: some View {
        List {
            ForEach(self.allData, id: \.self) {
                self.content($0)
            }
        }.id(self.uuid)
    }
}

//struct FilteredGamesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredGamesListView()
//    }
//}
