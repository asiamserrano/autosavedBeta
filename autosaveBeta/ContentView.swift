//
//  ContentView.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/9/26.
//

import SwiftUI
import SwiftData
import Core

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
//    @Query private var items: [Item]
    @Query private var properties: [Property]
    
    @State var builders: [Property.Builder] = .init()
    
    let uuid: UUID = .defaultValue

    var body: some View {
        NavigationStack {
            Form {
//                ForEach(builders) { property in
//                    OrientationStack(.vstack, {
//                        ForEach(property.data, id:\.self) { str in
//                            Text(str)
//                        }
//                    })
//                }
            }
            .navigationTitle(self.uuid.uuidString)
            .toolbar {
                ToolbarItem {
                    Button(action: addProperty) {
                        Label("Add Property", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addProperty() {
        withAnimation {
//            let newItem = Property.init()
            self.builders.append(.random)
//            modelContext.insert(newItem)
        }
    }

    private func deleteProperty(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(properties[index])
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Property.self, inMemory: true)
}
