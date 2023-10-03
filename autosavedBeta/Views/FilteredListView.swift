//
//  FilteredListView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI
import CoreData

struct FilteredListView<T: NSManagedObject, Content: View>: StandardViewProtocol {
        
    @EnvironmentObject var viewObject: ViewObject
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
        
    init(_ s: [NSSortDescriptor] = [], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping (T) -> Content) {
//        let predicate: NSPredicate = NSPredicate(format: "%K BEGINSWITH %@", key, value)
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
        self.content = content
    }

    var body: some View {
//        Text("my uuid: \(uuid.uuidString)")
        List(fetchRequest, id: \.self) {
            self.content($0)
        }.id(self.uuid)
    }

    
}
