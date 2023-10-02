//
//  Main+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//


import SwiftUI

struct MainView: StandardViewProtocol {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    
    //    @FetchRequest(entity: Property.entity(), sortDescriptors: [])
    //    var properties: FetchedResults<Property>
    //
    //    @FetchRequest(entity: Game.entity(), sortDescriptors: [])
    //    var games: FetchedResults<Game>
    
//    @State private var entity: EntityEnum = .property
    @State private var uuid: UUID = .init()
    
    /*
     1. add search to game view
     2. add filtering
     3. add properties listing view
     4. add stats view
     5. add wishlist
     
     
     TODO: add search to game view
     TODO: add filtering
     TODO: add properties listing view
     TODO: add stats view
     TODO: add wishlist
     
     */
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Entity", selection: $viewObject.entityEnum) {
                    ForEach(EntityEnum.all) {
                        Text($0.plural).tag($0)
                    }
                }
                .onChange(of: self.sortEnum, perform: self.setDirection)
//                .pickerStyle(.segmented)
                
                EntityListView()
            }
            .id(self.uuid)
            .onChange(of: self.hashValue, perform: self.updateID)
            .navigationTitle(self.entityEnum.plural)
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
    
    //    struct GamesView: View {
    //
    //        @Environment(\.managedObjectContext) private var viewContext
    //
    //        @FetchRequest(entity: Game.entity(), sortDescriptors: [])
    //        var games: FetchedResults<Game>
    //
    //        var body: some View {
    //            List {
    //                ListingView(content: <#T##(EntityProtocol) -> View#>)
    ////                ForEach(self.games, id:\.self) { game in
    ////                    NavigationLink(destination: {
    ////                        GameView(game)
    ////                    }, label: {
    ////                        HStack {
    ////                            Text(game.title)
    ////                        }
    ////                    })
    ////                }
    //    //                    ForEach(self.properties, id:\.self, content: PropertyView)
    //            }.id(UUID())
    //        }
    //
    //    }
    
    //    struct PropertiesView: View {
    //
    //        @Environment(\.managedObjectContext) private var viewContext
    //
    //        @FetchRequest(entity: Property.entity(), sortDescriptors: [])
    //        var properties: FetchedResults<Property>
    //
    //        var body: some View {
    //            List {
    //                ForEach(self.properties, id:\.self) { property in
    //                    FormView(property.builder.display, property.games.count)
    //                }
    //            }.id(UUID())
    //        }
    //
    //    }
    
    //    @ViewBuilder
    //    public func PropertyView(_ builder: Property) -> some View {
    //        VStack(alignment: .leading) {
    //            FormView("uuid", builder.uuid.uuidString)
    //            FormView("primary", builder.get(.primary))
    //            FormView("secondary", builder.get(.secondary))
    //            FormView("tertiary", builder.get(.tertiary))
    //            FormView("value", builder.get(.value))
    //        }
    //    }
    //
    //    @ViewBuilder
    //    public func BuilderView(_ p: Property) -> some View {
    //        let builder: PropertyEnum = .init(p)
    //        VStack(alignment: .leading) {
    //            FormView("primary", builder.get(.primary))
    //            FormView("secondary", builder.get(.secondary))
    //            FormView("tertiary", builder.get(.tertiary))
    //            FormView("value", builder.get(.value))
    //        }
    //    }
    
    //    @ViewBuilder
    //    public func PlatformEnumView(_ platform: PlatformEnum) -> some View {
    //        VStack(alignment: .leading) {
    //            FormView("key", platform.key)
    //            FormView("value", platform.value)
    //            FormView("enum", platform.defaultEnum.key)
    //            FormView("class", platform.defaultClass)
    ////            FormView("default value", platform.defaultValue)
    //        }
    //    }
    //
    //    @ViewBuilder
    //    public func BuilderView(_ game: Game.Builder) -> some View {
    //        VStack(alignment: .leading) {
    //            FormView("title", game.title)
    //            FormView("release", game.release.long)
    //            FormView("owned?", game.owned.description)
    //            FormView("image?", (game.image != nil).description)
    //            FormView("properties", game.properties.count.description)
    //        }
    //    }
    
    //    @ViewBuilder
    //    public func GameView(_ game: Game) -> some View {
    //        NavigationLink(destination: {
    //            GameView(game)
    //        }, label: {
    //            Text(game.title_string ?? .new)
    //        })
    ////        VStack(alignment: .leading) {
    ////            FormView("raw", game.raw_title_string)
    ////            FormView("title", game.title_string)
    ////            FormView("release", game.release_date?.long)
    ////            FormView("owned?", game.owned_boolean.description)
    ////            FormView("image?", (game.image_data != nil).description)
    ////            FormView("properties", game.properties_set?.count.description)
    ////        }
    //    }
    
    //    @ViewBuilder
    //    public func GameView(_ game: Game) -> some View {
    //        BuilderView(.init(game))
    //    }
    
    //    private var games: [GameBuilder] {
    //        [self.game()]
    //    }
    //
    //    private func game() -> GameBuilder {
    //
    //        var data: Data? {
    //            let string: String = ResourceReader.readString(.image)
    //            return Data(base64Encoded: string)
    //        }
    //
    //        let title: String = "Grand Theft Auto: Vice City"
    //        let date: Date = .init(2002, 10, 29)
    //
    //        return .init(title, date, data)
    //    }
    //
    //    private func properties() -> [PropertyBuilder] {
    //        [
    //            .init(.init(.series, "Grand Theft Auto")),
    //            .init(.init(.developer, "Rockstar North")),
    //            .init(.init(.publisher, "Rockstar Games")),
    //            .init(.init(.genre, "action adventure")),
    //            .init(.init(.single)),
    //            .init(.init(.playstation(.PS2), .physical(.disc))),
    //            .init(.init(.nintendo(.SWITCH), .physical(.card))),
    //            .init(.init(.nintendo(.SWITCH), .digital(.nintendo)))
    //        ]
    //    }
    
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ViewObjectKey.defaultValue)
    }
    
}
