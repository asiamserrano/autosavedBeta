//
//  ListingView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import SwiftUI

struct GameListingView<T: Game, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Game>
    
    @Binding var entity: EntityEnum

    // this is our content closure; we'll call this once for each item in the list
    let content: (Game) -> Content
    
    init(_ binding: Binding<EntityEnum>, @ViewBuilder content: @escaping (Game) -> Content) {
        self._fetchRequest = FetchRequest<Game>(sortDescriptors: [])
        self._entity = binding
        self.content = content
    }
    
    var body: some View {
        if self.entity == .game {
            List(fetchRequest, id: \.self) { self.content($0) }
        }
    }
    
}

struct PropertyListingView<T: Property, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Property>

    @Binding var entity: EntityEnum

    // this is our content closure; we'll call this once for each item in the list
    let content: (Property) -> Content
    
    init(_ binding: Binding<EntityEnum>, @ViewBuilder content: @escaping (Property) -> Content) {
        self._fetchRequest = FetchRequest<Property>(sortDescriptors: [])
        self._entity = binding
        self.content = content
    }

    var body: some View {
        if self.entity == .property {
            List(fetchRequest, id: \.self) { self.content($0) }
        }
    }
    
}


//
//struct ListingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListingView()
//    }
//}
