//
//  Classes.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/4/26.
//

import Foundation
import Core
import SwiftData
import SwiftUI


fileprivate protocol ClassProtocol: PersistentModel {}
fileprivate protocol FinalClassProtocol: ClassProtocol {
    var toString: String { get }
}

fileprivate extension Array where Element == SuperClass {
 
    func doFilter<T: FinalClassProtocol>(_ t: T.Type) -> [T] {
        self.compactMap { $0 as? T }
    }
    
}


@Model @available(iOS 26.0, *)
public class SuperClass: ClassProtocol {
    
    var int: Int = 0
    
    init() {}
  
    init(int: Int) {
        self.int = int
    }
    
}

@Model @available(iOS 26.0, *)
public class MyClass: SuperClass, FinalClassProtocol {
        
    var uuid: UUID = UUID()
    
    override init() {
        super.init()
    }

    init(uuid: UUID, int: Int) {
        self.uuid = uuid
        super.init(int: int)
    }
    
    var toString: String {
        "\(int) --> \(uuid.uuidString)"
    }
    
}

struct MyClassesView: View {
    
    @Environment(\.modelContext) public var modelContext
    
    @State var bool: Bool = true
    let uuid: UUID = .init()
    
    var body: some View {
        NavigationStack {
            Form {
                
                Text(uuid.uuidString)
                Text("boolean: \(bool.description)")
                
                Section {
                    FilteredMyClassesView<MyClass>(bool)
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Toggle") {
                        self.bool.toggle()
                    }
                    
                }
                
            }
        }
    }
    
    private struct FilteredMyClassesView<T>: View where T: FinalClassProtocol {
        
//        @Environment(\.modelContext) public var modelContext
        
        @Query private var mySuperClasses: [SuperClass]
        
        init(_ bool: Bool) {
            self._mySuperClasses = .init(.init(predicate: #Predicate<SuperClass> {
                ($0.int % 2 == 0) == bool
            }))
        }
        
        var body: some View {
            ForEach(mySuperClasses.doFilter(T.self)) {
                Text($0.toString)
            }
        }
    }
        
}

#Preview {

    let previewModelContainer: ModelContainer = {
        let container: ModelContainer = .preview
        
        10.forEach {
            let myClass = MyClass.init(uuid: .init(), int: Int.random(in: 0...20))
            container.mainContext.insert(myClass)
            try? container.mainContext.save()
        }
        
        return container
    }()

    MyClassesView()
        .modelContainer(previewModelContainer)
}
