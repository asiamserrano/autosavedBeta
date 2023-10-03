//
//  MainView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI
import CoreData

struct MainView: StandardViewProtocol {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationStack {
                    VStack {
                        switch self.menuEnum {
                        case .statistics: StatisticsView()
                        case .properties: PropertiesView()
                        default: GamesView
                        }
                    }
                    .navigationBarTitle("content view", displayMode: .large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) { MenuPicker }
//                        ToolbarItem(placement: .status) { FilteredValue }
                    }
                }
                
            }
            .onChange(of: self.hashValue, perform: self.updateID)
            .toolbar {
                
                ToolbarItem {

                    NavigationLink(destination: {
                        GameView()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    ViewPicker
                }
                
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
                
            }
        }
    }
    
    @ViewBuilder
    public var GamesView: some View {
        let sort: [NSSortDescriptor] = .gamesSortDesc(self.sortEnum, self.ascending)
        var predicate: NSPredicate? {
            if let bool: Bool = self.viewObject.menuEnum.status {
                let key: String = GameVariable.owned.rawValue
                return NSPredicate(format: "\(key) == %@", bool as NSNumber)
            } else { return nil }
        }
        FilteredListView(sort, predicate) { (game: Game) in
            NavigationLink(destination: {
                GameView(game)
            }, label: {
                GameListView(game)
            })
        }
    }
    
    @ViewBuilder
    var MenuPicker: some View {
        Menu(content: {
            Picker("Menu picker", selection: $viewObject.menuEnum) {
                ForEach(MenuEnum.allCases, id:\.self) { item in
                    HStack {
                        Text(item.value)
                        IconView(item.icon)
                    }
                }
            }.onChange(of: self.menuEnum, perform: self.reset)
//            .onChange(of: self.menuEnum) {
//                switch $0 {
//                case .library: return
//                default: self.viewObject.valueEnum = nil
//                }
//            }
        }, label: {
            Image(systemName: "line.3.horizontal")
        })
    }
    
    @ViewBuilder
    func MenuItem(_ title: String, _ icon: String? = nil) -> some View {
        HStack {
            Text(title)
            if let i: String = icon { IconView(i) }
        }
    }
    
    @ViewBuilder
    var ViewPicker: some View {
        Menu(content: {
            
            Picker("SortEnum", selection: self.sortBinding) {
                ForEach(SortEnum.filterForStatus(self.menuEnum == .library).reversed(), id:\.self) { item in
                    MenuItem(item.value, self.getSortIcon(item))
                }
            }
            
//            Picker("ViewEnum", selection: $viewObject.viewEnum.animation()) {
//                ForEach(ViewEnum.allCases.reversed(), id: \.self) { item in
//                    MenuItem(item.display, item.icon)
//                }
//            }
            
//            Picker("DeviceEnum", selection: self.viewObject.deviceBinding.animation()) {
//                ForEach(DeviceEnum.allCases.reversed(), id: \.self) { item in
//                    MenuItem(item.display.pluralize, item.icon)
//                }
//            }
            
        }, label: { Image(systemName: "ellipsis.circle") })
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ViewObjectKey.defaultValue)
    }
}
