////
////  Main+View.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////
//
//
//import SwiftUI
//import CoreData
//
//struct MainView: StandardViewProtocol {
//    
//    @Environment(\.managedObjectContext) var viewContext
//    @EnvironmentObject var viewObject: ViewObject
//    
//    //    @FetchRequest(entity: Property.entity(), sortDescriptors: [])
//    //    var properties: FetchedResults<Property>
//    //
////        @FetchRequest(entity: Game.entity(), sortDescriptors: [])
////        var games: FetchedResults<Game>
//    
////    @State private var entity: EntityEnum = .property
////    @State private var uuid: UUID = .init()
//    
//    /*
//     1. add search to game view
//     2. add filtering
//     3. add properties listing view
//     4. add stats view
//     5. add wishlist
//     
//     
//     TODO: add search to game view
//     TODO: add filtering
//     TODO: add properties listing view
//     TODO: add stats view
//     TODO: add wishlist
//     
//     */
//    
////    private var strings: [String] {
////        var u: Set<String> = .init()
////        while u.count <= 250 { u.insert(.random) }
////        let done: [String] = u.sorted()
////        return self.ascending ? done : done.reversed()
////    }
////
////    private var game_stucts: [GameStruct] {
////        let structs: [GameStruct] = self.games.map { .init($0) }.sorted(by: { GameStruct.sort(self.sortEnum, $0, $1) })
////        return self.ascending ? structs : structs.reversed()
////    }
//    
////    private struct GameStruct: IdentifiableProtocol {
////
////        private let raw_title: String
////        private let raw_release: String
////        let title: String
////        let release: Date
////
////        public init(_ game: Game) {
////            self.title = game.title
////            self.release = game.release
////            self.raw_title = game.title.canonicalized
////            self.raw_release = game.release.dashless
////        }
////
////        public var listString: String {
////            self.title + " (\(self.release.year))"
////        }
////
////        private static func equateTitle(_ lhs: Self, _ rhs: Self) -> Bool {
////            if lhs.raw_title == rhs.raw_title {
////                return lhs.raw_release < rhs.raw_release
////            } else { return lhs.raw_title < rhs.raw_title }
////        }
////
////        private static func equateRelease(_ lhs: Self, _ rhs: Self) -> Bool {
////            if lhs.raw_release == rhs.raw_release {
////                return lhs.raw_title < rhs.raw_title
////            } else { return lhs.raw_release < rhs.raw_release }
////        }
////
////        public static func sort(_ s: SortEnum, _ lhs: Self, _ rhs: Self) -> Bool {
////            switch s {
////            case .name: return Self.equateTitle(lhs, rhs)
////            case .release: return Self.equateRelease(lhs, rhs)
////            }
////        }
////
////
////    }
//        
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("uuid: \(self.uuid.uuidString)")
//                
////                List {
//////                    ForEach(self.game_stucts, id:\.self) { game in
//////                        NavigationLink(destination: {
//////                            VStack(alignment: .leading) {
//////                                Text("title: \(game.title)")
//////                                Text("release: \(game.release.long)")
//////                            }
//////                        }, label: {
//////                            Text(game.listString)
//////                        })
////////                        NavigationLink(destination: {
////////                            GameView(game)
////////                        }, label: {
////////                            Text(game.title)
////////                        })
//////                    }
//////                    ForEach(self.strings, id:\.self) { str in
//////                        NavigationLink(destination: {
//////                            Text("my partial uuid is: \(str)")
//////                        }, label: {
//////                            Text(str)
//////                        })
//////                    }
////                }
//                
////                VStack {
////                    switch self.menuEnum {
//////                    case .statistics: StatisticsView()
//////                    case .properties: PropertiesView()
////                    default: GamesView()
////                    }
////                }
////
////                ForEach(self.strings, id:\.self) {
////
////                }
//                
////                Picker("Entity", selection: $viewObject.entityEnum) {
////                    ForEach(EntityEnum.all) {
////                        Text($0.plural).tag($0)
////                    }
////                }
//              
//                
////                FilteredGamesListView() { game in
////                  GameListingView(game)
////                }
//                
//                
////                .pickerStyle(.segmented)
////                switch self.entityEnum {
////                case .game: ViewForGames
////                case .property: ViewForProperties
////                }
////                EntityListView() { FormView($0.tuple.header, $0.tuple.message) }
////                EntityListView() { ViewForT($0) }
//            }
////            .background {
////                NavigationLink(<#T##SwiftUI.LocalizedStringKey#>, destination: <#T##Destination#>, isActive: <#T##SwiftUI.Binding<Bool>#>)
////            }
////            .id(self.uuid)
//            .onChange(of: self.sortEnum, perform: self.setDirection)
//            .onChange(of: self.hashValue, perform: self.updateID)
//            .navigationTitle(self.entityEnum.plural)
//            .toolbar {
//                
//                ToolbarItem {
//                    
//                    NavigationLink(destination: {
//                        GameView()
//                    }, label: {
//                        Image(systemName: "plus")
//                    })
//                }
//                
//                if self.entityEnum == .game {
//                    ToolbarItemGroup(placement: .bottomBar, content: {
//                        
//                        Button("Sorted by: \(self.sortEnum.value)", action: self.nextSortEnum)
//                        
//                        Button(action: self.toggleDirection, label: {
//                            Image(systemName: "arrow.\(self.ascending ? "up" : "down")")
//                        })
//                        
//                    })
//                }
//
//            }
//
//        }
//    }
//    
//    //    struct GamesView: View {
//    //
//    //        @Environment(\.managedObjectContext) private var viewContext
//    //
//    //        @FetchRequest(entity: Game.entity(), sortDescriptors: [])
//    //        var games: FetchedResults<Game>
//    //
//    //        var body: some View {
//    //            List {
//    //                ListingView(content: <#T##(EntityProtocol) -> View#>)
//    ////                ForEach(self.games, id:\.self) { game in
//    ////                    NavigationLink(destination: {
//    ////                        GameView(game)
//    ////                    }, label: {
//    ////                        HStack {
//    ////                            Text(game.title)
//    ////                        }
//    ////                    })
//    ////                }
//    //    //                    ForEach(self.properties, id:\.self, content: PropertyView)
//    //            }.id(UUID())
//    //        }
//    //
//    //    }
//    
//    //    struct PropertiesView: View {
//    //
//    //        @Environment(\.managedObjectContext) private var viewContext
//    //
//    //        @FetchRequest(entity: Property.entity(), sortDescriptors: [])
//    //        var properties: FetchedResults<Property>
//    //
//    //        var body: some View {
//    //            List {
//    //                ForEach(self.properties, id:\.self) { property in
//    //                    FormView(property.builder.display, property.games.count)
//    //                }
//    //            }.id(UUID())
//    //        }
//    //
//    //    }
//    
//    //    @ViewBuilder
//    //    public func PropertyView(_ builder: Property) -> some View {
//    //        VStack(alignment: .leading) {
//    //            FormView("uuid", builder.uuid.uuidString)
//    //            FormView("primary", builder.get(.primary))
//    //            FormView("secondary", builder.get(.secondary))
//    //            FormView("tertiary", builder.get(.tertiary))
//    //            FormView("value", builder.get(.value))
//    //        }
//    //    }
//    //
//    //    @ViewBuilder
//    //    public func BuilderView(_ p: Property) -> some View {
//    //        let builder: PropertyEnum = .init(p)
//    //        VStack(alignment: .leading) {
//    //            FormView("primary", builder.get(.primary))
//    //            FormView("secondary", builder.get(.secondary))
//    //            FormView("tertiary", builder.get(.tertiary))
//    //            FormView("value", builder.get(.value))
//    //        }
//    //    }
//    
//    //    @ViewBuilder
//    //    public func PlatformEnumView(_ platform: PlatformEnum) -> some View {
//    //        VStack(alignment: .leading) {
//    //            FormView("key", platform.key)
//    //            FormView("value", platform.value)
//    //            FormView("enum", platform.defaultEnum.key)
//    //            FormView("class", platform.defaultClass)
//    ////            FormView("default value", platform.defaultValue)
//    //        }
//    //    }
//    //
//    //    @ViewBuilder
//    //    public func BuilderView(_ game: Game.Builder) -> some View {
//    //        VStack(alignment: .leading) {
//    //            FormView("title", game.title)
//    //            FormView("release", game.release.long)
//    //            FormView("owned?", game.owned.description)
//    //            FormView("image?", (game.image != nil).description)
//    //            FormView("properties", game.properties.count.description)
//    //        }
//    //    }
//    
//  
//    
//    //    @ViewBuilder
//    //    public func GameView(_ game: Game) -> some View {
//    //        BuilderView(.init(game))
//    //    }
//    
//    //    private var games: [GameBuilder] {
//    //        [self.game()]
//    //    }
//    //
//    //    private func game() -> GameBuilder {
//    //
//    //        var data: Data? {
//    //            let string: String = ResourceReader.readString(.image)
//    //            return Data(base64Encoded: string)
//    //        }
//    //
//    //        let title: String = "Grand Theft Auto: Vice City"
//    //        let date: Date = .init(2002, 10, 29)
//    //
//    //        return .init(title, date, data)
//    //    }
//    //
//    //    private func properties() -> [PropertyBuilder] {
//    //        [
//    //            .init(.init(.series, "Grand Theft Auto")),
//    //            .init(.init(.developer, "Rockstar North")),
//    //            .init(.init(.publisher, "Rockstar Games")),
//    //            .init(.init(.genre, "action adventure")),
//    //            .init(.init(.single)),
//    //            .init(.init(.playstation(.PS2), .physical(.disc))),
//    //            .init(.init(.nintendo(.SWITCH), .physical(.card))),
//    //            .init(.init(.nintendo(.SWITCH), .digital(.nintendo)))
//    //        ]
//    //    }
//    
//}
//
//struct MainView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        MainView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//            .environmentObject(ViewObjectKey.defaultValue)
//    }
//    
//}
