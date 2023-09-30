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
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        ResourceReader.readArray(.series).forEach {
            viewContext.fetchProperty(InputBuilder(.series, $0))
        }
        
        ResourceReader.readArray(.genre).forEach {
            viewContext.fetchProperty(InputBuilder(.genre, $0))
        }
        
        let builders: [PropertyBuilder] = [
            InputBuilder(.series, "Grand Theft Auto"),
            InputBuilder(.genre, "Action-Adventure"),
            InputBuilder(.developer, "Rockstar North"),
            InputBuilder(.publisher, "Rockstar Games"),
            ModeBuilder(.single),
            PlatformBuilder(.playstation(.ps4), .digital(.psn)),
            PlatformBuilder(.nintendo(.switch), .physical(.card))
        ]
        
        let game: Game = GameBuilder.init()
            .withTitle("Grand Theft Auto: Vice City")
            .withRelease(.init(2002, 10, 29))
            .withStatus(true)
            .withImage(.init(base64Encoded: ResourceReader.readString(.image)))
            .setProperties(builders)
            .build(viewContext)
        
        viewContext.store()
        
        return result
       
    }()
    
}
