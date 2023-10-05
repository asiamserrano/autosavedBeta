//
//  FilteredListView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI
import CoreData

struct FilteredListView<T: NSManagedObject, Content: View>: StandardViewProtocol {
    
    public enum ContentEnum {
        case single((T) -> Content)
        case array(([T]) -> Content)
    }
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
 
//    let content: (T) -> Content
    let content: ContentEnum
    let sortDescriptors: [SortDesc]
    let initPredicate: NSPredicate?
    let filterEnum: FilterEnum
    
    @State var search: String = .empty
    
    private var entityEnum: EntityEnum {
        self.filterEnum.entityEnum
    }
    
    private init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate?, _ c: ContentEnum) {
        self.content = c
        self.filterEnum = f
        self.sortDescriptors = s
        self.initPredicate = p
    }
        
    init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping (T) -> Content) {
        self.init(f, s, p, .single(content))
    }
    
    init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping ([T]) -> Content) {
        self.init(f, s, p, .array(content))
    }
    
    private var canon: String { self.search.canonicalized }
    
    private var predicateEnum: PredicateEnum? {
        switch canon.count {
        case 0: return nil
        case 1: return .begin
        default: return .contain
        }
    }
    
    private var finalPredicate: NSPredicate? {
        self.filterEnum.generate(self.predicateEnum, self.canon, self.initPredicate)
    }
    
    var body: some View {
//        VStack {
////            let arr: [T] = []
////            switch self.content {
////            case .single(let single): ForEach(arr, id:\.self) { single($0) }
////            case .array(let array): array(arr)
//
//            switch self.content {
//            case .single(let con): SingleView(self.entityEnum, con: con)
//            case .array(let con): ArrayView(self.entityEnum, con: con)
////            switch self.filterEnum.entityEnum {
////            case .game: FilteredGamesView(self.search, self.sortDescriptors, self.finalPredicate, content: self.content)
////            case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.finalPredicate, content: self.content)
////            case .property: FilteredPropertiesView(self.fetchRequest, content: self.content)
//            }
//        }
        CreateView
        .id(self.uuid)
        .searchable(text: $search, placement: .automatic)
    }
    
    @ViewBuilder
    public var CreateView: some View {
        switch self.content {
        case .single(let con): SingleView(self.entityEnum, con: con)
        case .array(let con): ArrayView(self.entityEnum, con: con)
        }
    }
    
    @ViewBuilder
    public func SingleView(_ e: EntityEnum, @ViewBuilder con: @escaping (T) -> Content) -> some View {
        List {
            switch e {
            case .game: FilteredGamesView(self.search, self.sortDescriptors, self.finalPredicate, content: con)
            case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.finalPredicate, content: con)
            }
        }
    }
    
    @ViewBuilder
    public func ArrayView(_ e: EntityEnum, @ViewBuilder con: @escaping ([T]) -> Content) -> some View {
        switch e {
        case .game: FilteredGamesView(self.search, self.sortDescriptors, self.finalPredicate, content: con)
        case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.finalPredicate, content: con)
        }
    }
 
    
}
