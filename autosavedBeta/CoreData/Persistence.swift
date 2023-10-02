//
//  Persistence.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "autosavedBeta")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private static func random(_ t: TypeEnum) -> PropertyBuilder {
        switch t {
        case .platform: return PlatformBuilder.random
        case .input: return InputBuilder.random
        case .mode: return ModeBuilder.random
        }
    }
    
//    private static func random() -> [PropertyBuilder] {
//        var arr: [PropertyBuilder] = .init()
//        let max: Int = .random(in: 2...10)
//        for _ in 0..<max { arr.append(random(.random)) }
//        return arr
//    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let max: Int = 100
        
        var master_properties: [PropertyBuilder] = .init()
        
        for _ in 0..<max { master_properties.append(random(.random)) }

        
        for _ in 0..<max {
            let str: String = .random
            let top: Int = .random(in: 3..<12)
            var indexes: Set<Int> = .init()
            for _ in 2..<top { indexes.insert(Int.random(in: 0..<max)) }
            var props: [PropertyBuilder] = indexes.map { master_properties[$0] }
            let game: Game = GameBuilder.init()
                .withTitle("Game \(str)")
                .withRelease(.random)
                .withStatus(true)
                .setProperties(props)
                .build(viewContext)
        }
        
//        ResourceReader.readArray(.series).forEach {
//            viewContext.fetchProperty(InputBuilder(.series, $0))
//        }
//
//        ResourceReader.readArray(.genre).forEach {
//            viewContext.fetchProperty(InputBuilder(.genre, $0))
//        }
//
//        let builders: [PropertyBuilder] = [
//            InputBuilder(.series, "Grand Theft Auto"),
//            InputBuilder(.genre, "Action-Adventure"),
//            InputBuilder(.developer, "Rockstar North"),
//            InputBuilder(.publisher, "Rockstar Games"),
//            ModeBuilder(.single),
//            PlatformBuilder(.playstation(.ps4), .digital(.psn)),
//            PlatformBuilder(.nintendo(.switch), .physical(.card))
//        ]
//
//        let game: Game = GameBuilder.init()
//            .withTitle("Grand Theft Auto: Vice City")
//            .withRelease(.init(2002, 10, 29))
//            .withStatus(true)
//            .withImage(.init(base64Encoded: ResourceReader.readString(.image)))
//            .setProperties(builders)
//            .build(viewContext)
        
        viewContext.store()
        
        return result
       
    }()
    
}
