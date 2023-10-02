//
//  autosavedBetaApp.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import SwiftUI

public let appScreenWidth: CGFloat = UIScreen.main.bounds.width
public let appScreenHeight: CGFloat = UIScreen.main.bounds.height
public let appDefaultColor: Color = .blue
public let appSecondaryColor: Color = .pink
@main
struct autosavedBetaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
