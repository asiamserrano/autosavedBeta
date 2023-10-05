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
        
        VStack {
            
            // TODO: not going to work this way - need to find how to get all properties into one view
            
            
//            ForEach(InputEnum.all) { input in
//                FilteredListView(.value, sort, .init(.secondary, InputEnum.series.key, .equal)) { (property: Property) in
//                    HStack {
//                        let inputBuilder: InputBuilder = .init(property)
//                        Text(inputBuilder.display)
//                    }
//                }
//            }
        }
//        List {
//
//
//
////            ForEach(InputEnum.all) { input in
////
////
////
//////                Section(input.display) {
//////
////////                    FilteredListView(.value, sort, .init(.secondary, input.key, .equal), content: InputEnumView)
//////                    ForEach(["one", "two", "three"], id:\.self) {
//////                        Text($0)
//////                    }
//////                }
////            }
//        }
        
        
//        Form {
//            ForEach(InputEnum.all) { input in
//                Section(input.display) {
//                    FilteredListView(.value, sort, .init(.secondary, input.key, .equal), content: InputEnumView)
////                    FilteredListView(.value, sort, .init(.secondary, input.key, .equal)) { (property: Property) in
////
////                    }
//
//
//            }
//        }
//        FilteredListView(.property, sort) { (property: Property) in
//            let key: String = property.get(.secondary)!
//            var value: String? {
//                switch property.typeEnum {
//                case .input: return property.get(.value)
//                case .platform: return property.get(.tertiary)
//                case .mode: return nil
//                }
//            }
//
//            Text("(\(key)) \(value.toString)")
//
////            FormView(key, value)
    }
    
    @ViewBuilder
    public func InputEnumView(_ props: [Property]) -> some View {
        ForEach(props) {
            let inputBuilder: InputBuilder = .init($0)
            Text(inputBuilder.display)
        }
    }
    
}
