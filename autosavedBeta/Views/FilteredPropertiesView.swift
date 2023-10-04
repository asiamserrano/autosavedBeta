//
//  FilteredPropertiesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/4/23.
//

import SwiftUI
import CoreData

struct FilteredPropertiesView<T: NSManagedObject, Content: View>: View {
    
    let content: (T) -> Content
    var properties: FetchedResults<T>
    
    init(_ items: FetchedResults<T>, @ViewBuilder content: @escaping (T) -> Content) {
        self.properties = items
        self.content = content
    }
    
    var body: some View {
        ForEach(self.properties, id: \.self) { item in
            self.content(item)
        }
    }
    
}
