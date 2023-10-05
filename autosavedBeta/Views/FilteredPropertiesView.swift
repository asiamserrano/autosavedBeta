////
////  FilteredPropertiesView.swift
////  autosavedBeta
////
////  Created by Asia Michelle Serrano on 10/4/23.
////
//
//import SwiftUI
//import CoreData
//
//struct FilteredPropertiesView<T: NSManagedObject, Content: View>: View {
//
//    public enum ContentEnum {
//        case single((T) -> Content)
//        case array(([T]) -> Content)
//    }
//
//    @Environment(\.managedObjectContext) var viewContext
//    @EnvironmentObject var viewObject: ViewObject
//    @FetchRequest var fetchRequest: FetchedResults<T>
//    
//    @ObservedObject var search: SearchObject
//
////    let content: (T) -> Content
//    let content: ContentEnum
//    
//    private var results: [T] { self.fetchRequest.results }
//
//    init(_ s: SearchObject, _ sort: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
//        _fetchRequest = FetchRequest<T>(sortDescriptors: sort, predicate: p)
//        self.content = .single(content)
//        self.search = s
//    }
//
//    init(_ s: SearchObject, _ sort: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping ([T]) -> Content) {
//        _fetchRequest = FetchRequest<T>(sortDescriptors: sort, predicate: p)
//        self.content = .array(content)
//        self.search = s
//    }
//    
//    var body: some View {
//        switch self.content {
//        case .single(let con): SingleView(single: con)
//        case .array(let con): ArrayView(array: con)
//        }
//    }
//
//    @ViewBuilder
//    private func SingleView(@ViewBuilder single: @escaping (T) -> Content) -> some View  {
//        ForEach(self.fetchRequest, id: \.self, content: single)
//    }
//
//    @ViewBuilder
//    private func ArrayView(@ViewBuilder array: @escaping ([T]) -> Content) -> some View  {
//        array(self.results)
//    }
//
//}
