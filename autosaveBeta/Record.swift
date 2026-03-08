//
//  Record.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/3/26.
//

import Foundation
import Core
import SwiftData
import CryptoKit
import SwiftUI
import Combine

fileprivate typealias HashID = PersistentHashID<Record>

fileprivate extension HashID {
    
    init(_title: String, canonicalized: String, date: String) {
        self.strict = .init(providing: Self.type, name: _title, date)
        self.fuzzy = .init(providing: Self.type, name: canonicalized, date)
    }
    
    enum Field {
        case title(String)
        case release(Date)
        
        var string: String? {
            switch self {
            case .title(let string): return string
            default: return nil
            }
        }
        
        var date: Date? {
            switch self {
            case .release(let date): return date
            default: return nil
            }
        }
        
    }
    
    struct Parameters {
        private let string: String
        private let date: Date
        
        init(string: String, date: Date) {
            self.string = string
            self.date = date
        }
        
        init(string s: String, date d: Date, field f: Field) {
            let string = f.string ?? s
            let date = f.date ?? d
            self.init(string: string, date: date)
        }
        
        var _release: Date { date }
        var _title: String { string.trimmed }
        var _title_editing: String { string }
        
        var hashID: HashID {
            .init(_title: _title, canonicalized: string.canonicalized, date: _release.dashless)
        }
        
    }
    
}

@Model @available(iOS 26.0, *)
public class Foo: PersistentProtocol {
    
    public enum FooEnum: Enumerable {
        case one, two, three
    }
    
    public private(set) var string: String = String.defaultValue
    
//    public required init(fooEnum: FooEnum) {
//        self.string = fooEnum.rawValue
//    }
    
    public init(fooEnum: FooEnum) {
        self.string = fooEnum.rawValue
    }
    
}

@Model @available(iOS 26.0, *)
public final class Record: Foo {
    
    private typealias Field = HashID.Field
    private typealias Parameters = HashID.Parameters
    
    @Transient
    private var _title_editing: String? = nil
    private var _title: String = String.defaultValue
    private var _release: Date = Date.now
    private var _added: Date = Date.now
    
//    public private(set) var string: String = String.defaultValue
    
    public private(set) var persistentID: UUID  = UUID.init() // stable, non changing
    public private(set) var strictHashID: UUID  = UUID.init()// comes from _title
    public private(set) var fuzzyHashID: UUID  = UUID.init()// comes from canon _title

    public var title: String {
        get { _title_editing ?? .defaultValue } set { set(.title(newValue)) }
    }
    
    public var release: Date {
        get { _release } set { set(.release(newValue)) }
    }
    
    public override init(fooEnum: FooEnum) {
//        self.string = fooEnum.rawValue
        super.init(fooEnum: fooEnum)
//        self.string = fooEnum.rawValue
    }
    
//    public required init(_ foo: FooEnum) {
////        self._title = .defaultValue
////        self._title_editing = .defaultValue
////        self._release = .now
////        let added: Date = .now
////        self._added = added
////        self.persistentID = .init(providing: Record.self, added)
////        self.strictHashID = .init()
////        self.fuzzyHashID = .init()
//        super.init(fooEnum: foo)
//    }
    
    public convenience init(title t: String, release r: Date, _ foo: FooEnum = .defaultValue) {
//        self.init(foo)
        self.init(fooEnum: foo)
        let parameters = Parameters(string: t, date: r)
        self.set(parameters)
    }
    
    private func set(_ field: Field) {
        let parameters: Parameters = .init(string: title, date: release, field: field)
        self.set(parameters)
    }
    
    private func set(_ parameters: Parameters) {
        self._title = parameters._title
        self._title_editing = parameters._title_editing
        self._release = parameters._release
        self.strictHashID = parameters.hashID.strict
        self.fuzzyHashID = parameters.hashID.fuzzy
    }
    
    public var toString: String {
        "\(self.title) (\(self.release.dashes))"
    }
    
    public var privateVariables: [String: String] {
        [
            "_title_editing": _title_editing ?? "null",
            "_title": _title,
            "_release": _release.dashes,
            "_added": _added.dashes
        ]
    }
    
}

extension Record: Randomizable {
    
    public static var random: Record {
        .init(fooEnum: .random)
//        .init(title: .random, release: .random, .random)
    }
    
}

struct RecordsView: View {
    
    @Environment(\.modelContext) public var modelContext
    
    @State var foo: Foo.FooEnum = .defaultValue
    
    var body: some View {
        NavigationStack {
            Form {
                
                Picker("Picker", selection: $foo, content: {
                    ForEach(Foo.FooEnum.cases) {
                        Text($0.rawValue).tag($0)
                    }
                }).pickerStyle(.segmented)
                
                Section {
                    FilteredRecords(foo)
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Add") {
                        let record = Record.random
                        self.modelContext.insert(record)
                        try? self.modelContext.save()
                    }
                    
                }
                
            }
        }
    }
    
    private struct FilteredRecords: View {
        
        @Environment(\.modelContext) public var modelContext
        
        @Query var records: [Record]
        
        init(_ foo: Foo.FooEnum) {
            let string = foo.rawValue
            self._records = .init(.init(predicate: #Predicate<Record> {
                $0.string == string
            }))
        }
        
        var body: some View {
            ForEach(records) { record in
                Text(record.toString)
            }
        }
    }
    
    private struct RecordView: View {
        
        @Environment(\.modelContext) public var modelContext
        
        @Bindable var record: Record
                
        var body: some View {
            Form {
                
//                Picker("Picker", selection: $foo, content: {
//                    ForEach(Foo.FooEnum.cases) {
//                        Text($0.rawValue).tag($0)
//                    }
//                }).pickerStyle(.segmented)
                
                
//                Section("Private") {
//                    ForEach(record.privateVariables.sorted(), id:\.key) { key, value in
//                        Text("\(key)\n\(value)")
//                    }
//                }
//                
//                Section("Info") {
//                    SpacedLabel("title", record.title)
//                    SpacedLabel("release", record.release.dashes)
//                    SpacedLabel("persistentID", record.persistentID.uuidString)
//                    SpacedLabel("strictHashID", record.strictHashID.uuidString)
//                    SpacedLabel("fuzzyHashID", record.fuzzyHashID.uuidString)
//                }
//               
//                TextField("Title", text: $record.title)
//                DatePicker("Release", selection: $record.release, displayedComponents: .date)
            }
//            .onAppear {
//                print("persistentID: \(record.persistentID)")
//                print("strictHashID: \(record.strictHashID)")
//                print("fuzzyHashID: \(record.fuzzyHashID)")
//            }
            .toolbar {
                
    //            ToolbarItem(placement: .topBarTrailing, content: {
    //                Button("Mutate Title") {
    //                    record.title += " *"
    //                }
    //            })
                
            }
        }
        
    }
    
}





#Preview {

    let previewModelContainer: ModelContainer = {
        let container: ModelContainer = .preview
        
//        let record = Record.init(title: "Grand Theft Auto: Vice City", release: .fromString(dashless: "20021029"))
//        
//        container.mainContext.insert(record)
//        try? container.mainContext.save()
        
        15.forEach {
            let record = Record.random
            container.mainContext.insert(record)
            try? container.mainContext.save()
        }
        
        return container
    }()

    RecordsView()
        .modelContainer(previewModelContainer)
}
