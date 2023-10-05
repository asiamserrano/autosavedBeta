////
////  FilteredListView.swift
////  autosavedBeta
////
////  Created by Asia Michelle Serrano on 10/3/23.
////
//
//import SwiftUI
//import CoreData
//
//struct FilteredListView<T: NSManagedObject, Content: View>: StandardViewProtocol {
//    
////    public enum ContentEnum {
////        case single((T) -> Content)
////        case array(([T]) -> Content)
////    }
//    
//    @Environment(\.managedObjectContext) var viewContext
//    @EnvironmentObject var viewObject: ViewObject
// 
//    @StateObject var search: SearchObject = .init()
//    let content: (T) -> Content
////    let content: ContentEnum
//    let sortDescriptors: [SortDesc]
//    let initPredicate: NSPredicate?
////    let filterEnum: FilterEnum
//    
////    @State var search: String = .empty
//    
////    private var entityEnum: EntityEnum {
////        self.filterEnum.entityEnum
////    }
//    
//    let entityEnum: EntityEnum
//    
////    private init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate?, _ c: ContentEnum) {
////        self.content = c
//////        self.filterEnum = f
////        self.sortDescriptors = s
////        self.initPredicate = p
////    }
//    
//    public static func searchForGames(_ vo: ViewObject, @ViewBuilder content: @escaping (T) -> Content) -> Self {
//        .init(vo, content: content)
//    }
//    
//    public static func searchForPlatforms(_ p: PlatformEnum, @ViewBuilder content: @escaping (T) -> Content) -> Self {
//        .init(.property, .propertiesSortDesc(), .init(.secondary, p.key, .equal), content: content)
//    }
//    
//    public static func searchForFormats(_ f: FormatEnum, @ViewBuilder content: @escaping (T) -> Content) -> Self {
//        .init(.property, .propertiesSortDesc(), .init(.tertiary, f.key, .equal), content: content)
//    }
//    
//    public static func searchForModes(@ViewBuilder content: @escaping (T) -> Content) -> Self {
//        .init(.property, .propertiesSortDesc(), .init(.primary, TypeEnum.mode.key, .equal), content: content)
//    }
//    
//    private init(_ vo: ViewObject, @ViewBuilder content: @escaping (T) -> Content) {
//        self.content = content
//        self.entityEnum = .game
//        self.sortDescriptors = .gamesSortDesc(vo.sortEnum, vo.ascending)
//        self.initPredicate = {
//            if let bool: Bool = vo.menuEnum.status {
//                let key: String = GameVariable.owned.rawValue
//                return NSPredicate(format: "\(key) == %@", bool as NSNumber)
//            } else { return nil }
//        }()
//    }
//    
//    private init(_ e: EntityEnum, _ s: [NSSortDescriptor], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
//        self.content = content
//        self.entityEnum = e
//        self.sortDescriptors = s
//        self.initPredicate = p
//    }
//    
////    private init(_ p: PlatformEnum, @ViewBuilder content: @escaping (T) -> Content) {
////        self.init(.property, .propertiesSortDesc(), .init(.secondary, p.key, .equal), content: content)
////    }
////
////    private init(_ f: FormatEnum, @ViewBuilder content: @escaping (T) -> Content) {
////        self.init(.property, .propertiesSortDesc(), .init(.terti, f.key, .equal), content: content)
////    }
//    
////    public init(_ vo: ViewObject, _ t: TypeEnum, @ViewBuilder content: @escaping (T) -> Content) {
////        self.content = content
////        self.entityEnum = .game
////        self.sortDescriptors = .gamesSortDesc(vo.sortEnum, vo.ascending)
////        self.initPredicate = {
////            if let bool: Bool = vo.menuEnum.status {
////                let key: String = GameVariable.owned.rawValue
////                return NSPredicate(format: "\(key) == %@", bool as NSNumber)
////            } else { return nil }
////        }()
////    }
//    
//    
////    private init(_ e: EntityEnum, _ s: [SortDesc], _ p: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
////        self.content = content
////        self.entityEnum = e
////        self.sortDescriptors = s
////        self.initPredicate = p
////    }
//    
////    private init(_ e: EntityEnum, _ s: [SortDesc], _ p: NSPredicate?, _ c: ContentEnum) {
////        self.content = c
////        self.entityEnum = e
////        self.sortDescriptors = s
////        self.initPredicate = p
////    }
//    
////    init(_ e: EntityEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping (T) -> Content) {
////        self.init(e, s, p, .single(content))
////    }
////
////    init(_ e: EntityEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping ([T]) -> Content) {
////        self.init(e, s, p, .array(content))
////    }
//        
////    init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping (T) -> Content) {
////        self.init(f, s, p, .single(content))
////    }
//    
//    
//    
////    init(_ f: FilterEnum, _ s: [SortDesc], _ p: NSPredicate? = nil, @ViewBuilder content: @escaping ([T]) -> Content) {
////        self.init(f, s, p, .array(content))
////    }
//    
////    private var predKey: String {
////        switch self.entityEnum {
////        case .game: return GameVariable.raw.rawValue
////        case .property do {
////
////            case .value: return PropertyVariable.value.rawValue
////            case .tertiary: return PropertyVariable.tertiary.rawValue
////            case .secondary: return PropertyVariable.secondary.rawValue
////        }
////        }
////    }
//    
////    public func generate(_ pe: PredicateEnum?, _ str: String, _ old: NSPredicate?) -> NSPredicate? {
////        if let predEn: PredicateEnum = pe {
////            let newPred: NSPredicate = .init(predKey, str, predEn)
////            if let initPred: NSPredicate = old {
////                return NSCompoundPredicate(andPredicateWithSubpredicates: [initPred, newPred])
////            } else { return newPred }
////        } else {
////            if let o: NSPredicate = old { return o }
////            else { return nil }
////        }
////    }
//    
////    private var canon: String { self.search.canonicalized }
//    
//    
//    var body: some View {
//        CreateView
//        .id(self.uuid)
//        .searchable(text: $search.input, placement: .automatic)
//    }
//    
//    @ViewBuilder
//    public var CreateView: some View {
//        switch self.entityEnum {
//        case .game: FilteredGamesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//        case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//        }
////        switch self.content {
////        case .single(let con): SingleView(self.entityEnum, con: con)
////        case .array(let con): ArrayView(self.entityEnum, con: con)
////        }
//    }
//    
//    @ViewBuilder
//    public func SingleView(_ e: EntityEnum, @ViewBuilder con: @escaping (T) -> Content) -> some View {
//        List {
//            switch e {
//            case .game: FilteredGamesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//            case .property: Text("TBD single")
////            case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//            }
//        }
//    }
//    
//    @ViewBuilder
//    public func ArrayView(_ e: EntityEnum, @ViewBuilder con: @escaping ([T]) -> Content) -> some View {
//        switch e {
//        case .game: FilteredGamesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//        case .property: Text("TBD array")
////        case .property: FilteredPropertiesView(self.search, self.sortDescriptors, self.initPredicate, content: con)
//        }
//    }
// 
//    
//}
