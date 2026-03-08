////
////  Example.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/26/26.
////
//
//import Foundation
//import Core
//import SwiftData
//
////// MARK: Base Models
////
/////*
//// ExampleAttribute.self, ExampleProperty.self, ExamplePlatformProperty.self, ExampleGame.self, ExampleInputProperty.self,
//// ExampleModeProperty.self, ExampleSystemProperty.self, ExampleFormatProperty.self, ExamplePlatform.self
//// */
////
////@Model @available(iOS 26, *)
////public class ExampleAttribute: ClassNameProviding, UUID.Providing {
////    
////    public private(set) var uuid: UUID
////    public private(set) var games: [ExampleGame]
////    
////    fileprivate init() {
////        self.uuid = .defaultValue
////        self.games = .defaultValue
////    }
////    
////    public func insert(_ game: ExampleGame) {
////        self.games = self.games + [game]
////    }
////    
////    public func remove(_ game: ExampleGame) -> Void {
////        self.games = self.games.filter { $0.uuid != game.uuid }
////    }
////    
////    public var properties: [ExampleProperty] { [] }
////    
////    public var toString: String { .defaultValue }
////
////}
////
////@Model @available(iOS 26, *)
////public class ExampleProperty: ExampleAttribute {
////    
////    public typealias Identifier = Property.Identifier
////    
////    public private(set) var propertyIdentifier: String
////    public private(set) var rawValue: String
////    
////    public init(_ identifier: Identifier, _ value: String) {
////        self.propertyIdentifier = identifier.rawValue
////        self.rawValue = value.trimmed
////        super.init()
////    }
////    
////    public override var properties: [ExampleProperty] { [self] }
////    
////    public override var toString: String {
////        self.rawValue
////    }
////    
////}
//
////@Model @available(iOS 26, *)
////public class ExamplePlatformProperty: ExampleProperty {
////    
////    public private(set) var platforms: [ExamplePlatform]
////    
////    public enum Identifier: Enumerable {
////        case system, format
////        
////        var propertyIdentifier: ExampleProperty.Identifier {
////            switch self {
////            case .system:
////                return .system
////            case .format:
////                return .format
////            }
////        }
////        
////    }
////    
////    public private(set) var platformIdentifier: String
////    
////    public init(_ identifier: Identifier, _ value: String) {
////        self.platformIdentifier = identifier.rawValue
////        self.platforms = .defaultValue
////        super.init(identifier.propertyIdentifier, value)
////    }
////    
////}
//
////// MARK: Final Models
////
////@Model @available(iOS 26, *)
////public final class ExampleGame:  ClassNameProviding, UUID.Providing {
////    
////    public static var random: Self {
////        let g: Self = .init()
////        g.title = .random
////        g.release = .random
////        return g
////    }
////    
////    public private(set) var uuid: UUID
////    public var title: String
////    public var release: Date
////    
////    @Relationship(inverse: \ExampleAttribute.games)
////    public private(set) var attributes: [ExampleAttribute]
////    
////    public init() {
////        self.uuid = .defaultValue
////        self.title = .defaultValue
////        self.release = .defaultValue
////        self.attributes = .defaultValue
////    }
////    
////    public var properties: [ExampleProperty] {
////        let array: [ExampleProperty] = self.attributes.flatMap(\.properties)
////        let set: Set<ExampleProperty> = Set(array)
////        return set.sorted(by: { $0.propertyIdentifier < $1.propertyIdentifier })
////    }
////    
////    public func insert(_ attribute: ExampleAttribute) -> Void {
////        self.attributes = self.attributes + [attribute]
////    }
////    
////    public func remove(_ attribute: ExampleAttribute) -> Void {
////        self.attributes = self.attributes.filter { $0.uuid != attribute.uuid }
////    }
////    
////    public var toString: String {
////        "\(title.trimmed) (\(self.release.dashes))"
////    }
////    
////}
////
////@Model @available(iOS 26, *)
////public final class ExampleInputProperty: ExampleProperty {
////    
////    public typealias Identifier = Input.Identifier
////    
////    public private(set) var inputIdentifier: String
////    
////    private init(_ identifier: Identifier, _ value: String) {
////        self.inputIdentifier = identifier.rawValue
////        super.init(.input, value)
////    }
////    
////    
////    public convenience init(_ builder: Input.Builder) {
////        self.init(builder.type, builder.rawValue)
////    }
////    
////    public override var toString: String {
////        "(\(self.inputIdentifier)) \(self.rawValue)"
////    }
////    
////}
////
////@Model @available(iOS 26, *)
////public final class ExampleModeProperty: ExampleProperty {
////    
////    public enum Identifier: Enumerable {
////        
////        case single, two, multi
////        
////        public var rawValue: String {
////            switch self {
////            case .single: return "Single-Player"
////            case .two: return "Two-Player"
////            case .multi: return "Multiplayer"
////            }
////        }
////        
////    }
////    
////    public init(_ identifier: Identifier) {
////        super.init(.mode, identifier.rawValue)
////    }
////    
////    public override var toString: String {
////        self.rawValue
////    }
////    
////}
////
////@Model @available(iOS 26, *)
////public final class ExampleSystemProperty: ExamplePlatformProperty {
////    
////    public typealias Identifier = System.Identifier
////        
////    public private(set) var systemIdentifier: String
////    
////    
////    public init(_ registry: System.Registry) {
////        self.systemIdentifier = registry.identifier.rawValue
////        super.init(.system, registry.rawValue)
////    }
////    
////}
////
////@Model @available(iOS 26, *)
////public final class ExampleFormatProperty: ExamplePlatformProperty {
////    
////    public typealias Identifier = Format.Identifier
////        
////    public private(set) var formatIdentifier: String
////    
////    
////    public init(_ registry: Format.Registry) {
////        self.formatIdentifier = registry.identifier.rawValue
////        super.init(.format, registry.rawValue)
////    }
////    
////}
////
////@Model @available(iOS 26, *)
////public final class ExamplePlatform: ExampleAttribute {
////    
////    @Relationship(inverse: \ExampleSystemProperty.platforms)
////    public private(set) var system: ExampleSystemProperty?
////    
////    @Relationship(inverse: \ExampleFormatProperty.platforms)
////    public private(set) var format: ExampleFormatProperty?
////
////    public init(system: ExampleSystemProperty?, format: ExampleFormatProperty?) {
////        self.system = system
////        self.format = format
////        super.init()
////    }
////    
////    public override var properties: [ExampleProperty] {
////        [self.system, self.format].compactMap(\.self)
////    }
////    
////    
////    public override var toString: String {
////        let s = self.system?.rawValue ?? "system"
////        let f = self.format?.rawValue ?? "format"
////        return "\(s) | \(f)"
////    }
////    
////}
//import Combine
//
//
//@Model @available(iOS 26, *)
//final class Employee: PersistentModelProtocol, Randomizable {
//    
//    static var random: Employee {
//        .init(name: .random, idNumer: .random(in: 10000...99999))
//    }
//    
//    var uuid: UUID
//    var name: String
//    var idNumber: Int
//    
//    @Relationship(inverse: \Trip.employee)
//    public var trips: [Trip]
//    
//    private init(name: String, idNumer: Int) {
//        self.uuid = .init()
//        self.name = name
//        self.idNumber = idNumer
//        self.trips = .init()
//    }
//    
//    public func insert(_ business: BusinessTrip) {
//        self.trips.append(business)
//    }
//    
//    public var toString: String {
//        "\(name) - \(idNumber)"
//    }
//
//    
//}
//
//@Model @available(iOS 26, *)
//class Trip: PersistentModelProtocol {
//    
//    static func random( _ identifier: Identifier) -> Trip {
//        switch identifier {
//        case .business:
//            return BusinessTrip.random
//        case .personal:
//            return PersonalTrip.random
//        }
//    }
//    
//    public enum Identifier: Enumerable {
//        case business, personal
//    }
//    
//    var uuid: UUID
//    var identifier: String
//    var destination: String
//    var startDate: Date
//    
//    public var employee: Employee? = nil
//    
//    public init(_ identifier: Identifier, destination: String, startDate: Date) {
//        self.uuid = .init()
//        self.identifier = identifier.rawValue
//        self.destination = destination
//        self.startDate = startDate
//    }
//    
//    public var toString: String {
//        let person = employee?.toString ?? "nil"
//        return "identifier: \(identifier)\ndestination: \(destination)\nstartDate: \(startDate.dashes)\nemployee: \(person)"
//    }
//    
//}
//
//@Model @available(iOS 26, *)
//final class BusinessTrip: Trip, Randomizable {
//    
//    static var random: BusinessTrip {
//        .init(pdm: .random, destination: .random, startDate: .random)
//    }
//    
//    var pdm: String // business-specific property
//    
//    private init(pdm: String, destination: String, startDate: Date) {
//        self.pdm = pdm
//        super.init(.business, destination: destination, startDate: startDate)
//    }
//    
//    public override var toString: String {
//        return "pdm: \(pdm)\n\(super.toString)"
//    }
//}
//
//@Model @available(iOS 26, *)
//final class PersonalTrip: Trip, Randomizable {
//    
//    static var random: PersonalTrip {
//        .init(reason: .random, destination: .random, startDate: .random)
//    }
//    
//    var reason: String // personal-specific property
//    
//    private init(reason: String, destination: String, startDate: Date) {
//        self.reason = reason
//        super.init(.personal, destination: destination, startDate: startDate)
//    }
//    
//    public override var toString: String {
//        return "reason: \(reason)\n\(super.toString)"
//    }
//    
//}
//
//import SwiftUI
//
//struct ExampleView: View {
//    
//    @Environment(\.modelContext) public var modelContext
//    
//    public enum Models: Enumerable {
//        case employee, trip
//    }
//    
//    var className: String {
//        switch self.model {
//        case .employee:
//            Employee.className
//        case .trip:
//            switch self.trip {
//            case .business:
//                BusinessTrip.className
//            case .personal:
//                PersonalTrip.className
//            }
//        }
//    }
//    
////    @Query private var games: [ExampleGame]
////    @Query private var properties: [ExampleProperty]
////    @Query private var platforms: [ExamplePlatform]
//    
//    @Query private var employees: [Employee]
//    @Query private var trips: [Trip]
//    
//    @State var model: Models = .defaultValue
//    @State var trip: Trip.Identifier = .defaultValue
//    
//    var filteredTrips: [Trip] {
//        self.trips.filter { $0.identifier == self.trip.rawValue }
//    }
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                switch self.model {
//                case .employee:
//                    ExampleModelView(self.employees)
//                case .trip:
//                    
//                    Picker(.defaultValue, selection: $trip, content: {
//                        ForEach(Trip.Identifier.cases) { trip in
//                            Text(trip.rawValue).tag(trip)
//                        }
//                    }).pickerStyle(.segmented)
//                    
//                    ExampleModelView(self.filteredTrips)
//                }
//            }
//            .toolbar {
//                
//                ToolbarItem(placement: .bottomBar, content: {
//                
//                    Picker(.defaultValue, selection: $model, content: {
//                        ForEach(Models.cases) { model in
//                            Text(model.rawValue).tag(model)
//                        }
//                    }).pickerStyle(.segmented)
//                })
//                
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Add", action: createEmployeeAndTrip)
//                })
//                
//            }
//            .onAppear {
//                if employees.isEmpty {
//                    10.forEach(action: createEmployeeAndTrip)
//                }
//            }
//        }
//    }
//    
//    private func createEmployeeAndTrip() -> Void {
//        let employee = Employee.random
//        let trip = Trip.random(.random)
//        
//        employee.trips.append(trip)
//        
//        modelContext.insert(employee)
//        modelContext.insert(trip)
//        
//        try? modelContext.save()
//    }
//    
//    @ViewBuilder
//    private func ExampleModelView<T: PersistentModelProtocol>(_ t: [T]) -> some View {
//        ExampleModelView(self.className, t)
//    }
//    
//}
//
//#Preview {
//
//    let previewModelContainer: ModelContainer = {
//        let container: ModelContainer = .forType("Company", types: [Employee.self, Trip.self, BusinessTrip.self, PersonalTrip.self])
//        return container
//    }()
//
//    ExampleView()
//        .modelContainer(previewModelContainer)
//}
