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

    @State var nsset: NSSet = .init()
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    public var items: [String] {
        self.nsset.map { item in
            if let string: String = item as? String {
                return "string: \(string)"
            } else if let uuid: UUID = item as? UUID {
                return "uuid: \(uuid.uuidString)"
            } else if let input: InputBuilder = item as? InputBuilder {
                return "input builder: \(input.inputEnum.value) | \(input.value)"
            } else if let mode: ModeBuilder = item as? ModeBuilder {
                return "mode builder: \(mode.modeEnum.value)"
            } else if let platform: PlatformBuilder = item as? PlatformBuilder {
                return "platform builder: \(platform.platformEnum.value) | \(platform.formatEnum.value)"
            } else {
                return "unknown: \(String(describing: item))"
            }
        }
    }
    
    @State var string: String = .empty

    var body: some View {
        NavigationView {
            Form {
                
                TextField("Input", text: $string)
                
                Button("add") {
                    let new: InputBuilder = .init(.developer, self.string)
                    self.nsset =  self.nsset.insert(new)
                    self.string = .empty
                    print("added")
                }.disabled(self.string.canonicalized.isEmpty)
                
                ForEach(self.items, id:\.self) { item in
                    Text(item)
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
