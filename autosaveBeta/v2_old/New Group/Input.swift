//
//  Input.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 1/28/26.
//

import Foundation
import Core

public struct Input {
    
    public enum Identifier: Enumerable {
        case series, developer, publisher, genre
    }
    
    public struct Builder: V3UUIDNamespaceProviding {
        
        public let type: Identifier
        public let rawValue: String

        public init(_ t: Identifier, _ s: String) {
            self.type = t
            self.rawValue = s.trimmed
        }
        
        public var type_id: String {
            self.type.id
        }
        
        public var value_id: String {
            self.rawValue.canonicalized
        }
        
        public var uuid: UUID {
            self.namespace.uuid(enumerable: self.type, self.value_id, self.rawValue)
        }
        
    }
    
}

extension Input.Builder: Randomizable {
    
    public static var random: Self {
        .random(.random)
    }
    
    public static func random(_ i: Input.Identifier) -> Self {
        .init(i, .random)
    }
    
}

// -- MARK: Preview

import SwiftUI

struct InputBuilderView: View {
        
    @State var input: Input.Builder = .init(.series, "Grand Theft Auto")
     
    var body: some View {
        NavigationStack {
            Form {
                
                
                Section(input.rawValue) {
                    Text("namespace uuid: \(input.namespace.uuidString)")
                    Text("uuid: \(input.uuid)")
                }
                
//                EnumerableV3UUIDView(Input.Enum.self)
//                EnumerableV3UUIDView(Format.Identifier.self)
//                EnumerableV3UUIDView(Format.Registry.self)
//                EnumerableV3UUIDView(Format.Registry.DigitalEnum.self)
                
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Random") {
                        self.input = .init(.random, .random)
                    }
                })
                
            }
            
        }
    }
    
    @ViewBuilder
    private func EnumerableV3UUIDView<T: Enumerable>(_ t: T.Type) -> some View {
        Section(t.className) {
            Text("namespace: \(t.namespace.uuidString)")
            ForEach(T.cases) { object in
                Text("\(object.rawValue): \(object.uuid)")
            }
        }
    }
    
}

#Preview {
    InputBuilderView()
}
