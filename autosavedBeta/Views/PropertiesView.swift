//
//  PropertiesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI

struct PropertiesView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
//    @ViewBuilder
    //    public var PropertiesView: some View {
    //        let sort: [NSSortDescriptor] = .propertiesSortDesc()
    //        FilteredListView(sort) { (property: Property) in
    //            let key: String = property.get(.secondary)!
    //            var value: String? {
    //                switch property.typeEnum {
    //                case .input: return property.get(.value)
    //                case .platform: return property.get(.tertiary)
    //                case .mode: return nil
    //                }
    //            }
    //
    //            FormView(key, value)
    //        }
    //    }
}

struct PropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        PropertiesView()
    }
}
