////
////  FilteredListView.swift
////  autosavedBeta
////
////  Created by Asia Michelle Serrano on 10/2/23.
////
//
//import SwiftUI
//import CoreData
//
////struct EntityListView<T: ManObj>: View {
//struct EntityListView<T: ManObj, Content: View>: View {
//    
////    private enum ContentEnum {
////        case single((T) -> Content)
////        case array(([T]) -> Content)
////    }
//    
//    @Environment(\.managedObjectContext) var viewContext
////    @EnvironmentObject var viewObject: ViewObject
//    
//    @State var search: String = .empty
//    @State var uuid: UUID = .init()
//    
//    let content: (T) -> Content
////    private let content: ContentEnum
////    private let builder: EntityBuilder
//    
//    init(_ request: Fetch@ViewBuilder content: @escaping (T) -> Content) {
//        self.content = content
//    }
//    
////    @Binding var entity: EntityEnum
//
////    private init(_ build: EntityBuilder, _ con: ContentEnum) {
//////        self.content = con
////        self.builder = build
////    }
//    
////    public init(_ e: Binding<EntityEnum>) {
////        self._entity = e
////    }
//    
////    @Binding var entity: EntityEnum
//    
////    public init(_ e: Binding<EntityEnum>) {
////        self._entity = e
////    }
//
//    
////    init(_ builder: EntityBuilder, @ViewBuilder content: @escaping (T) -> Content) {
////        self.init(builder, .single(content))
////    }
//    
////    init(_ builder: FilteredListBuilder, @ViewBuilder content: @escaping ([T]) -> Content) {
////        self.init(builder, .array(content))
////    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            List {
//                ForEach(self.allData, id: \.self) {
//                    self.content($0)
//                }
//            }
//            .id(self.uuid)
// 
//
////            .onChange(of: self.entity, perform: self.updateUUID)
////            if (self.isAllDataEmpty || self.isFilteredDataEmpty) && self.propertyActionIsNil {
////                var text: String {
////                    if self.isAllDataEmpty {
////                        let d: DeviceEnum = self.viewObject.deviceEnum
////                        let a: String = "\(d.display) \(self.viewObject.menuEnum.id) is empty."
////                        let b: String = "Add a \(d.id) with the plus button!"
////                        return "\(a) \(b)"
////                    } else { return "No search results found." }
////                }
////
////                Text(text)
////                    .multilineTextAlignment(.center)
////                    .italicText()
////                    .padding()
////
////            } else {
////                if self.builder.entityEnum == .property { ListView.listStyle(.insetGrouped) }
////                else { ListView.listStyle(.automatic) }
////            }
//        }
////        .onAppear(perform: self.updateIsDisabled)
//////        .onChange(of: self.viewObject.id, perform: self.updateUUID)
////        .onChange(of: self.isAllDataEmpty, perform: self.updateIsDisabled)
////        .searchable(text: $search).disabled(self.isAllDataEmpty)
//    }
//    
////    @ViewBuilder
////    private var ListView: some View {
////        List {
////            switch self.content {
////            case .single(_):
////                ForEach(self.allData, id: \.self) {
////                    Text($0.string)
////                }
//////                    .onDelete(perform: self.delete)
////            case .array(_): Text("TBD")
////
//////                if let act: (String) -> Void = self.builder.propertyAction {
//////                    if !self.key.isEmpty && !self.allStrings.contains(self.key) {
//////                        Section {
//////                            let str: String = self.search.trimmed
//////                            TextFormButton("Add \'\(str)\'") { act(str) }
//////                        }
//////                    }
//////                }
//////
//////                Section { content(self.filteredData) }
////            }
////
////        }
////        .id(self.uuid)
////
////    }
//    
//}
//
//private extension EntityListView {
//        
//    var allData: [T] {
//        self.viewContext.fetchEntities(self.viewObject) as! [T]
////        self.builder.createData(self.viewContext) as! [T]
//    }
//    
////    var filteredData: [T] {
////        self.key.isEmpty ? self.allData :
////        self.allData.filter {
////            self.validate(self.builder.createString(cast($0)))
////        }
////    }
//    
////    var allStrings: [String] {
////        self.allData.map { self.builder.createString(cast($0)).stripped }
////    }
//    
////    var propertyActionIsNil: Bool {
////        self.builder.propertyAction == nil
////    }
//    
////    var isAllDataEmpty: Bool {
////        self.allData.isEmpty
////    }
////
////    var isFilteredDataEmpty: Bool {
////        self.filteredData.isEmpty
////    }
////
////    var listStyle: any ListStyle {
////        self.propertyActionIsNil ? .automatic : .insetGrouped
////    }
//    
////    func cast(_ a: NSManagedObject) -> Identifier {
////        a as! Identifier
////    }
//    
////    func delete(_ offsets: IndexSet) -> Void {
////        if let index: Int = offsets.first {
////            if let device: Device = self.filteredData[index] as? Device {
////                self.deleteAction(device)
////            }
////        }
////    }
//    
//    func updateUUID(_ e: EntityEnum) -> Void {
////        self.search = .empty
//        self.uuid = .init()
////        self.viewObject.uuid = .init()
////        self.uuid = self.builder.viewObject?.uuid ?? self.viewObject.uuid
//    }
//    
////    func updateIsDisabled() -> Void {
////        self.updateIsDisabled(self.isAllDataEmpty)
////    }
////
////    func updateIsDisabled(_ b: Bool) -> Void {
////        self.viewObject.isDisabled = b
////    }
//    
//}
