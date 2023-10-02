//
//  ContentView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import SwiftUI
import CoreData
import Foundation

public struct FoobarStruct: Identifiable, Equatable {
    public var id: Int
    public var uuid: UUID
    
    init(id: Int, uuid: UUID) {
        self.id = id
        self.uuid = uuid
    }
    
    init(id: Int) {
        self.id = id
        self.uuid = .init()
    }
    
    public var toString: String {
        "id: \(self.id) | uuid: \(self.uuid.uuidString)"
    }
    
    public func hasher(_ hash: HashEnum) -> Int {
        var hasher: Hasher = Hasher()
        switch hash {
        case .key: do {
            hasher.combine(self.id)
        }
        case .value: do {
            hasher.combine(self.id)
            hasher.combine(self.uuid)
        }
        }
        
        return hasher.finalize()
    }
    
    public static func equals(_ foo: Self, _ bar: Self, _ h: HashEnum) -> Bool {
        foo.hasher(h) == bar.hasher(h)
    }
    
}

//public struct HasherStruct {
//
//    public typealias FS = FoobarStruct
//    public typealias HE = HashEnum
//
//    public static func hash(_ foo: FS, _ hash: HE) -> Int {
//        var hasher = Hasher()
//        switch hash {
//        case .key: do {
//            hasher.combine(foo.id)
//        }
//        case .value: do {
//            hasher.combine(foo.id)
//            hasher.combine(foo.uuid)
//        }
//        }
//        let int: Int = hasher.finalize()
//        return int
//    }
//
//    public static func equals(_ a: FS, _ b: FS, _ h: HE) -> Bool {
//        Self.hash(a, h) == Self.hash(b, h)
//    }
//
//}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    let a1: FoobarStruct = .init(id: 0)
    let a2: FoobarStruct = .init(id: 0)
    
    @State var hash: HashEnum = .key

    var body: some View {
        NavigationView {
            Form {
                Button("change hash: \(self.hash.value)") {
                    self.hash = self.hash.toggle()
                }
                
                FormView("equals?", FoobarStruct.equals(a1, a2, self.hash))
                Section {
                    FormView("a1 hash", a1.hasher(self.hash))
                    FormView("a2 hash", a2.hasher(self.hash))
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
