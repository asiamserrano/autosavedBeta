//
//  MainView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI
import CoreData

struct MainView: StandardViewProtocol {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Entity", selection: $viewObject.entityEnum) {
                    ForEach(EntityEnum.all) {
                        Text($0.plural).tag($0)
                    }
                }
                switch self.entityEnum {
                case .game: GamesView
                case .property: PropertiesView
                }
            }
            .onChange(of: self.hashValue, perform: self.updateID)
            .toolbar {
                
                ToolbarItem {

                    NavigationLink(destination: {
                        GameView()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                if self.entityEnum == .game {
                    ToolbarItemGroup(placement: .bottomBar, content: {
                        
                        Button("Sorted by: \(self.sortEnum.value)", action: self.nextSortEnum)
                        
                        Button(action: self.toggleDirection, label: {
                            Image(systemName: "arrow.\(self.ascending ? "up" : "down")")
                        })
                        
                    })
                }
                
            }
        }
    }
    
    @ViewBuilder
    public var GamesView: some View {
        let sort: [NSSortDescriptor] = .gamesSortDesc(self.sortEnum, self.ascending)
        FilteredListView(sort) { (game: Game) in
            NavigationLink(destination: {
                GameView(game)
            }, label: {
                GameListView(game)
            })
        }
    }
    
    @ViewBuilder
    public var PropertiesView: some View {
        let sort: [NSSortDescriptor] = .propertiesSortDesc()
        FilteredListView(sort) { (property: Property) in
            let key: String = property.get(.secondary)!
            var value: String? {
                switch property.typeEnum {
                case .input: return property.get(.value)
                case .platform: return property.get(.tertiary)
                case .mode: return nil
                }
            }
            
            FormView(key, value)
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ViewObjectKey.defaultValue)
    }
}
