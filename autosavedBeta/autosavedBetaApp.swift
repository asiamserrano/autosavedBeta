//
//  autosavedBetaApp.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import SwiftUI

@main
struct autosavedBetaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
