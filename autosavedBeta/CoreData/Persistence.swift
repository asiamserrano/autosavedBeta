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
    
    private static var max: Int = 100
    
    @discardableResult
    private static func grandTheftAuto(_ con: Context) -> Game {
        let builders: [PropertyBuilder] = [
            InputBuilder(.series, "Grand Theft Auto"),
            InputBuilder(.genre, "Action-Adventure"),
            InputBuilder(.developer, "Rockstar North"),
            InputBuilder(.publisher, "Rockstar Games"),
            ModeBuilder(.single),
            PlatformBuilder(.playstation(.ps4), .digital(.psn)),
            PlatformBuilder(.nintendo(.switch), .physical(.card))
        ]
        
        return GameBuilder.init()
            .withTitle("Grand Theft Auto: Vice City")
            .withRelease(.init(2002, 10, 29))
            .withStatus(true)
            .withImage(.init(base64Encoded: ResourceReader.readString(.image)))
            .withDictionary(builders)
            .build(con)
    }
    
    private static func readResources(_ con: Context, _ i: InputEnum, _ r: ResourceReader.Files) {
        ResourceReader.readArray(r).forEach {
            con.fetchProperty(InputBuilder(i, $0))
        }
    }
    
    static func populate(_ viewContext: Context) -> Void {
        var mp: [PropertyBuilder] = .init()
        while mp.count < max {
            let new: PropertyBuilder = random(.random)
            if !mp.contains(where: { $0.hashValue == new.hashValue }) {
                mp.append(new)
            }
        }
        
        for _ in 0..<max {
            let str: String = .random
            let owned: Bool = .random()
            var props: [PropertyBuilder] {
                if owned {
                    let top: Int = .random(in: 3..<12)
                    var indexes: Set<Int> = .init()
                    for _ in 2..<top { indexes.insert(Int.random(in: 0..<max)) }
                    return indexes.map { mp[$0] }
                } else { return .init() }
            }
            
            GameBuilder.init()
//                .withTitle("Game \(str)")
                .withTitle(str)
                .withRelease(.random)
                .withRandomAddDate()
                .withStatus(owned)
                .withDictionary(props)
                .build(viewContext)
        }
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        populate(viewContext)
        
//        for int in 1..<3 {
//            GameBuilder.init()
//                .withTitle("Game\(int)")
////                .withRelease(.today)
////                .withStatus(true)
////                .withDictionary(props)
//                .build(viewContext)
//        }
        

        
//        master_games(viewContext)
        
//        let str: String = .random
//        let date: Date = .random
//
//        for _ in 0..<3 {
//            GameBuilder.init()
//                .withTitle("Game \(str)")
//                .withRelease(.random)
//                .withStatus(true)
//                .build(viewContext)
//
//            GameBuilder.init()
//                .withTitle("Game " + .random)
//                .withRelease(date)
//                .withStatus(true)
//                .build(viewContext)
//        }
        
        viewContext.store()
        
        return result
       
    }()
    
}
