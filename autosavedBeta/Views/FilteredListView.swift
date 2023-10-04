//
//  FilteredListView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI
import CoreData

struct FilteredListView<T: NSManagedObject, Content: View>: StandardViewProtocol {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    @FetchRequest var fetchRequest: FetchedResults<T>
 
    let content: (T) -> Content
    let localEntity: EntityEnum
        
    init(_ e: EntityEnum, _ s: [SortDesc] = [], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
        self.content = content
        self.localEntity = e
    }

    var body: some View {
        List {
            switch self.localEntity {
            case .game: FilteredGamesView(self.fetchRequest, content: self.content)
            case .property: FilteredPropertiesView(self.fetchRequest, content: self.content)
            }
        }
        .id(self.uuid)
    }
 
    
}
