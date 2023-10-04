//
//  PropertiesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI

struct PropertiesView: View {
    
    private let sort: [NSSortDescriptor] = .propertiesSortDesc()
    
    var body: some View {
        FilteredListView(.property, sort) { (property: Property) in
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
