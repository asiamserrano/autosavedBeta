////
////  ContentView.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/9/26.
////
//
//import SwiftUI
//import SwiftData
//import Core
//
//struct ContentView: ModelContextView {
//    
//    @Environment(\.modelContext) public var modelContext
//    
////    @Query private var items: [Item]
//    @Query private var games: [Game]
//    
//    var body: some View {
//        NavigationStack {
//            
//            Form {
//                ForEach(self.games) { game in
//                    Text("\(game.title) (\(game.release.dashes))")
//                }
//            }
//            .toolbar {
//                
//                NavigationLink(destination: {
//                    GamesView()
//                }, label: {
//                    Text("Add Games")
//                })
//                
//            }
//            
//            
////            if let game = self.games.first {
////                Form {
////                    NavigationLink(destination: {
////                        GameEditor(game: game)
////                    }, label: {
////                        Text("\(game.title) (\(game.release.dashes))")
////                    })
////                    
////                }
////            }
//        }
//    }
//    
//    
//    struct GamesView: ModelContextView {
//        
//        @Environment(\.modelContext) var modelContext
//        @Environment(\.dismiss) private var dismiss //
//        @State var games: [Game] = .init()
//
//        var isSaveDisabled: Bool {
//            self.games.count == 0
//        }
//
//        var body: some View {
//            Form {
//                
//                Section {
//                    Button("Add") {
//                        self.games.append(.random)
//                    }
//                }
//                
//                ForEach(self.games) { game in
//                    Text("\(game.title) (\(game.release.dashes))")
//                }
//            }
//            .navigationBarBackButtonHidden()
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
////                        self.games = .init()
//                        self.dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        self.games.forEach({ self.modelContext.save($0, action: .insert) })
//                        self.dismiss()
//                    }
//                    .disabled(self.isSaveDisabled)
//                }
//            }
//        }
//    }
//    
//    struct GameEditor: ModelContextView {
//        @Environment(\.modelContext) var modelContext
//        @Environment(\.dismiss) private var dismiss //
//        @ObservedObject var game: Game
//        @State private var snapshot: Game.Snapshot
//        
//        init(game: Game) {
//            self.game = game
//            self._snapshot = .init(initialValue: game.snapshot)
//        }
//        
//        var isSaveDisabled: Bool {
//            self.snapshot.equals(self.game, by: .variables)
//        }
//
//        var body: some View {
//            Form {
//                Section {
//                    Text("\(self.snapshot.variables.description)")
//                    Text("equals: \(self.isSaveDisabled.description)")
//                }
//                TextField("Title", text: $game.title)
//                DatePicker("Release", selection: $game.release, displayedComponents: .date)
//            }
//            .navigationBarBackButtonHidden()
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        // End the group and undo everything in it
////                        modelContext.undoManager?.endUndoGrouping()
////                        modelContext.undoManager?.undo()
////                        modelContext.undoManager?.beginUndoGrouping()
//                        // Optionally, if there’s any leftover nested groups, you can loop:
//                        // while modelContext.undoManager?.canUndo == true { modelContext.undoManager?.undo() }
//                        
//                        self.snapshot.develop(self.game)
//                        self.dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        // End the group, but do not undo — then save
////                        modelContext.undoManager?.endUndoGrouping()
//                        modelContext.save(self.game)
////                        modelContext.undoManager?.beginUndoGrouping()
//                        self.snapshot = self.game.snapshot
//                    }
//                    .disabled(self.isSaveDisabled)
//                }
//            }
//        }
//    }
//
////    struct ParentView1: View {
////        @Environment(\.modelContext) private var modelContext
////        @Environment(\.modelContainerRef) private var modelContainer
////        
////        @State var game: Game?
////
////        var body: some View {
////            Group {
////                if let game {
////                    GameView(game: game)
////                        .id(game.persistentModelID)
////                } else {
////                    Text("No game")
////                }
////            }
////            .toolbar {
////                Button("Refetch") {
////                    if let modelContainer = self.modelContainer {
////                        let before = game.map { ObjectIdentifier($0) }
////                        // Use a fresh context:
////                        let fresh = modelContainer.newContext()
////                        // Fetch by UUID in the fresh context
////                        if let uuid: UUID = game?.uuid, let persisted: Game = fresh.fetch(#Predicate<Game> { $0.uuid == uuid }) {
////                            // Important: you cannot pass a managed object from one context to another context directly.
////                            // For demo purposes, you can copy values into the current context object:
////                            self.game?.title = persisted.title
////                            self.game?.release = persisted.release
////                        }
////                        let after = game.map { ObjectIdentifier($0) }
////                        print("Refetched Game ref changed? \(before != after)")
////                    }
////                }
////            }
////        }
////    }
//
//    struct GameView: View {
//        @ObservedObject var game: Game
//
//        var body: some View {
//            Form {
//                TextField("Title", text: $game.title)
//                DatePicker("Release", selection: $game.release, displayedComponents: .date)
//                Text("Object ID: \(ObjectIdentifier(game).hashValue)") // proves reference identity
//            }
//        }
//    }
//    
//}
//
//#Preview {
////
//    let previewModelContainer: ModelContainer = {
//
//        let container: ModelContainer = .preview
//
//        container.mainContext.autosaveEnabled = false
//        container.mainContext.undoManager = .init()
//        
//        container.mainContext.save(Game.random, action: .insert)
//
//        return container
//
//    }()
//
//    ContentView()
//        .modelContainer(previewModelContainer)
//}
