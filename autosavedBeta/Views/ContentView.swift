//
//  ContentView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    @State var string: String = .empty

    var body: some View {
        NavigationView {
            Form {
                ForEach(ResourceReader.readArray(.series), id:\.self) {
                    Text($0)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
