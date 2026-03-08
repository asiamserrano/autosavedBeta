//
//  ExampleGameView.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/2/26.
//

import SwiftUI
import SwiftData
import Core

struct ExampleGameView: View {
    
    @Environment(\.modelContext) public var modelContext
    
    @Query private var games: [ExampleGame]
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(games) { game in
                    NavigationLink(destination: {
                        InnerView(game: game)
                    }, label: {
                        Text(game.toString)
                    })
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Add", action: {
                        let game = ExampleGame.random
                        modelContext.insert(game)
                        try? modelContext.save()
                    })
                
                })
                
            }
        }
    }
    
    private struct InnerView: View {
        
        @Environment(\.modelContext) public var modelContext
        
        @ObservedObject var game: ExampleGame
        
        var body: some View {
            NavigationStack {
                Form {
                    Section("Info") {
                        Text(game.uuid.uuidString)
                    }
                    TextField("Title", text: game.titleBinding)
                    DatePicker("Release", selection: game.releaseBinding, displayedComponents: .date)
                }
            }
        }
        
    }
    
    
}

#Preview {
    
    ExampleGameView()
        .modelContainer(.forType(ExampleGame.self))
    
}
