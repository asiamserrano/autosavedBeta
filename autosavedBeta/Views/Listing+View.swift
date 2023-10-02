//
//  ListingView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import SwiftUI

struct GameListingView<T: Game, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Game>

    // this is our content closure; we'll call this once for each item in the list
    let content: (Game) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { self.content($0) }
    }
    
    init(@ViewBuilder content: @escaping (Game) -> Content) {
        _fetchRequest = FetchRequest<Game>(sortDescriptors: [])
        self.content = content
    }
    
}

struct PropertyListingView<T: Property, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Property>

    // this is our content closure; we'll call this once for each item in the list
    let content: (Property) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { self.content($0) }
    }
    
    init(@ViewBuilder content: @escaping (Property) -> Content) {
        _fetchRequest = FetchRequest<Property>(sortDescriptors: [])
        self.content = content
    }
    
}


//
//struct ListingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListingView()
//    }
//}
