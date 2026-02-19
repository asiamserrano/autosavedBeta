//
//  Input.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 1/28/26.
//

import Foundation
import Core

public struct Input {
    
    public enum Enum: Enumerable {
        case series, developer, publisher, genre
    }
    
    public struct Builder {
        
        public let type: Enum
        public let str: Str

        public init(_ t: Enum, _ s: String) {
            self.type = t
            self.str = .init(string: s)
        }

    }
    
}

extension Input.Builder: BuilderKit.Interface {
    
    public static var random: Self {
        .random(.random)
    }
    
    public static func random(_ i: Input.Enum) -> Self {
        .init(i, .random)
    }
    
    public var rawValue: String { self.str.rawValue }

    public var compound: Compound {
        .init(first: self.type, last: self.str.id)
    }
    
    public var valueCompound: Compound {
        .init(first: self.str.id, last: self.str.rawValue)
    }
    
}

// -- MARK: Preview

import SwiftUI

struct InputBuilderView: View {
    
    let builder: Input.Builder = .init(.series, "Grand Theft Auto")
     
    var body: some View {
        NavigationStack {
            Form {
                SpacedLabel("type", self.builder.type.rawValue)
                SpacedLabel("value", self.builder.rawValue)
                SpacedLabel("compound id", self.builder.compound.id)
                SpacedLabel("compound hash", self.builder.compound.hashValue.description)
            }
            
        }
    }
    
}

#Preview {
    InputBuilderView()
}
