//
//  ModelKitView.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/19/26.
//

import SwiftUI
import Core
import SwiftData

struct ModelKitView: ModelKit.Model.View.Interface {
        
    private typealias Enum = Persistent.Model.Enum
    
    @Environment(\.modelContext) public var modelContext
    
    @Query private var games: [Game]
    @Query private var properties: [Property]
    @Query private var platforms: [Platform]
    
    @State private var type: Enum = .defaultValue
    
    var body: some View {
        NavigationStack {
            switch self.type {
            case .game: ModelView(models: self.games, PickerView)
            case .property: ModelView(models: self.properties, PickerView)
            case .platform: ModelView(models: self.platforms, PickerView)
            }
        }
    }
    
    @ViewBuilder
    private func PickerView() -> some View {
        Picker("Picker", selection: $type, content: {
            ForEach(Enum.cases) { m in
                Text(m.rawValue).tag(m)
            }
        }).pickerStyle(.segmented)
    }

    private struct ModelView<Model: ModelKit.Model.Interface, T: View>: ModelKit.Model.View.Interface {
        
        typealias Models = [Model]
        typealias Builder = Model.Builder
        typealias Content = () -> T
        
        @Environment(\.modelContext) public var modelContext
        
        let models: Models
        let ContentView: Content
        
        init(models: Models, @ViewBuilder _ content: @escaping Content) {
            self.models = models
            self.ContentView = content
        }
        
        var body: some View {
            Form {
                
                ContentView()
                
                ForEach(self.models, id:\.id) { model in
                    NavigationLink(destination: {
                        Form {
                            DebugView("model", model.debug)
                            DebugView("builder", model.builder.debug)
                        }
                    }, label: {
                        Text(model.rawValue)
                    })
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let model: Model = self.models[index]
                        
                    }
                })
            }
            .navigationTitle(Model.modelType.rawValue)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Add") {
                        self.modelContext.random(Model.modelType)
                    }
                })
                
            }
        }
        
        @ViewBuilder
        private func DebugView(_ title: String, _ debug: Builder.Debug) -> some View {
            Section(title) {
                ForEach(debug) { element in
                    SpacedLabel(element.key, element.value)
                }
            }
        }
        
    }
    
}

#Preview {
    ModelKitView()
        .modelContainer(.preview)
}
