//
//  FilteredPropertiesView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/4/23.
//

import SwiftUI
import CoreData

struct FilteredPropertiesView<T: NSManagedObject, Content: View>: View {

    public enum ContentEnum {
        case single((T) -> Content)
        case array(([T]) -> Content)
    }

    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewObject: ViewObject
    @FetchRequest var fetchRequest: FetchedResults<T>

//    let content: (T) -> Content
    let content: ContentEnum

    init(_ str: String, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
//        self.content = content
        self.content = .single(content)
    }

    init(_ str: String, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping ([T]) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: s, predicate: p)
//        self.content = content
        self.content = .array(content)
    }

    var body: some View {
        switch self.content {
        case .single(let con): SingleView(single: con)
        case .array(let con): ArrayView(array: con)
        }
    }

    @ViewBuilder
    private func SingleView(@ViewBuilder single: @escaping (T) -> Content) -> some View  {
        ForEach(self.fetchRequest, id: \.self) { item in
            single(item)
        }
    }

    @ViewBuilder
    private func ArrayView(@ViewBuilder array: @escaping ([T]) -> Content) -> some View  {
        array(self.fetchRequest.map { $0 })
    }

}
