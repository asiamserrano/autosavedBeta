//
//  Item.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/9/26.
//

import Foundation
import UIKit
import SwiftData
import Core
import SwiftUI


@Model
final class Item {
    
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
    
}

struct ItemView: View {
    var body: some View {
        Text(Input.Builder.className)
    }
}

#Preview {
    Previewer {
        ItemView()
    }
}

//
//public class ModelObjects {
//    
//    public enum Initializer {
//        case random, defaultValue
//    }
//    
//}
//
//public protocol InitializerModel: PersistentModel {
//    typealias Initializer = ModelObjects.Initializer
//    var toString: String { get }
//}
//
//public protocol IterableModel: UUIDPersistentModel, InitializerModel {
//        
//    var value: String { get }
//}
//
//public protocol Animal: InitializerModel {
//    var name: String { get }
//    var diet: Diet { get }
//}



//#Preview {
//    
//    let previewModelContainer: ModelContainer = {
//        
//        let container: ModelContainer = .IN_MEMORY
//    
//        return container
//        
//    }()
//    
//    return MyView()
//        .modelContainer(previewModelContainer)
//}




/*
 struct AllModelsView: View {
     
     @Environment(\.modelContext) public var modelContext
     
     @Query private var diets: [Diet]
     @Query private var breeds: [Breed]
     @Query private var dogs: [Dog]
     
     var body: some View {
         
         NavigationStack {
             Form {
                 IterableModelView("Diets", self.diets)
                 IterableModelView("Breeds", self.breeds)
                 
                 Section("Dogs") {
                     ForEach(self.dogs) { dog in
                         Text(dog.toString)
                     }
                 }
             }
             .navigationTitle("Iterable Models")
         }
         
     }
     
     @ViewBuilder
     private func IterableModelView<T: IterableModel> (_ string: String, _ models: [T]) -> some View {
         Section(string) {
             ForEach(models) {
                 Text($0.toString)
             }
         }
     }
     
 }
 
 #Preview {
     
     let previewModelContainer: ModelContainer = {
         
         let container: ModelContainer = .preview
         
         container.mainContext.autosaveEnabled = false
         container.mainContext.undoManager = .init()
         
         
         //        Breed.cases.forEach {
         //            container.mainContext.save($0, action: .insert)
         //        }
         //
         //        Diet.cases.forEach {
         //            container.mainContext.save($0, action: .insert)
         //        }
         
         for _ in 0..<10 {
             
             let dog: Dog = .init(.random)
             let diet = container.mainContext.save(dog.diet, action: .insert)
             print("adding diet '\(diet.value)' --> \(diet.uuid.uuidString) --> \(diet.id)")
             let breed = container.mainContext.save(dog.breed, action: .insert)
             print("adding breed '\(breed.value)' --> \(breed.uuid.uuidString) --> \(breed.id)")
             container.mainContext.save(dog, action: .insert)
             
         }
         
         return container
         
     }()
     
     return AllModelsView()
         .modelContainer(previewModelContainer)
 }
 */

//struct DogsView: ModelContextView {
//
//    @Environment(\.modelContext) public var modelContext
//
//    @Query private var diets: [Diet]
//
//    @State var diet: Diet = .defaultValue
//
//    var body: some View {
//
////                NavigationStack {
////                    Form {
////                        ForEach(Diet.Option.cases) {                             Text($0.id)
////                        }
////
////                    }
////                }
//
//
//        NavigationStack {
//            Form {
//                Section("Diets") {
//                    ForEach(self.diets) { diet in
//                        Text(diet.toString)
//                    }
//                }
//
//                Picker(.defaultValue, selection: $diet, content: {
//                    ForEach(Diet.cases) { diet in
//                        Text(diet.value).tag(diet)
//                    }
//                }).pickerStyle(.segmented)
//
//                FilteredAnimalsView(diet: self.diet)
//
//            }
//            .navigationTitle(self.diet.value.capitalized)
//            .toolbar {
//
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Button") {}
//                })
//
//            }
//        }
//    }
//
//    struct FilteredAnimalsView: ModelContextView {
//
//        @Environment(\.modelContext) public var modelContext
//
////        @Query var animals: [Animal]
//        @Query var dogs: [Animal.Dog]
//
//        init(diet: Diet) {
//            //            self._animals = .init(filter: #Predicate<Animal> {
//            //                $0.diet == diet
//            //            }, sort: .defaultValue)
//
//            self._dogs = .init(filter: .dietPredicate(diet))
//
//        }
//
//        var body: some View {
//            ForEach(self.dogs) { dog in
//                Text(dog.toString)
//            }
//        }
//
//        //        var body: some View {
//        //            NavigationStack {
//        //                Form {
//        //                    ForEach(self.animals) { animal in
//        //                        Text(animal.toString)
//        //                    }
//        //                }
//        //                .toolbar {
//        //
//        //                    ToolbarItem(placement: .topBarTrailing, content: {
//        //                        Button("Button") {}
//        //                    })
//        //
//        //                }
//        //            }
//        //        }
//
//    }
//
//}
//
//struct AnimalsView: ModelContextView {
//
//    @Environment(\.modelContext) public var modelContext
//
//    @Query private var diets: [Diet]
//
//    @State var diet: Diet = .defaultValue
//    //    @State var diet2: Diet2 = .defaultValue
//
//    var body: some View {
//
////                NavigationStack {
////                    Form {
////                        ForEach(Diet.Option.cases) {                             Text($0.id)
////                        }
////
////                    }
////                }
//
//
//        NavigationStack {
//            Form {
//                Section("Diets") {
//                    ForEach(self.diets) { diet in
//                        Text(diet.toString)
//                    }
//                }
//
//                Picker(.defaultValue, selection: $diet, content: {
//                    ForEach(Diet.cases) { diet in
//                        Text(diet.value).tag(diet)
//                    }
//                }).pickerStyle(.segmented)

//                FilteredAnimalsView(diet: self.diet)
//
//            }
//            .navigationTitle(self.diet.value.capitalized)
//            .toolbar {
//
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Button") {}
//                })
//
//            }
//        }
//    }
//
//    struct FilteredAnimalsView: ModelContextView {
//
//        @Environment(\.modelContext) public var modelContext
//
////        @Query var animals: [Animal]
//        @Query var dogs: [Animal.Dog]
//
//        init(diet: Diet) {
//            //            self._animals = .init(filter: #Predicate<Animal> {
//            //                $0.diet == diet
//            //            }, sort: .defaultValue)
//
//            self._dogs = .init(filter: .dietPredicate(diet))
//
//        }
//
//        var body: some View {
//            ForEach(self.dogs) { dog in
//                Text(dog.toString)
//            }
//        }
//
//        //        var body: some View {
//        //            NavigationStack {
//        //                Form {
//        //                    ForEach(self.animals) { animal in
//        //                        Text(animal.toString)
//        //                    }
//        //                }
//        //                .toolbar {
//        //
//        //                    ToolbarItem(placement: .topBarTrailing, content: {
//        //                        Button("Button") {}
//        //                    })
//        //
//        //                }
//        //            }
//        //        }
//
//    }
//
//}



//extension NSValueTransformerName {
//
//    static let dietTransformer = NSValueTransformerName(DietTransformer.Name)
//
//
//    //    private init(_ c: AnyObject.Type) {
//    //        self.init(String(describing: c.self))
//    //    }
//
//}

//public enum Diet2: String, Identifiable, Codable, Hashable, CaseIterable, Iterable { // String-backed enum
//
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.rawValue == rhs.rawValue
//    }
//
//    case herbivorous
//    case carnivorous
//    case omnivorous
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(self.rawValue)
//    }
//
//    public var id: String { self.rawValue }
//
//}

//public final class Diet: NSObject, Identifiable, Codable, CaseIterable, Iterable, NSSecureCoding {
//
//    private static let VALUE: String = "value"
//
//    public static var supportsSecureCoding: Bool { true }
//
//    public func encode(with coder: NSCoder) {
//        coder.encode(value, forKey: Self.VALUE)
//    }
//
//    public required init?(coder: NSCoder) {
//        if let decodedColor = coder.decodeObject(forKey:  Self.VALUE) as? String {
//            self.value = decodedColor
//        } else {
//            return nil
//        }
//    }
//
//    private enum Option: Enumerable {
//        case herbivorous, carnivorous, omnivorous
//
//        var diet: Diet {
//            switch self {
//            case .herbivorous: return .herbivorous
//            case .carnivorous: return .carnivorous
//            case .omnivorous: return .omnivorous
//            }
//        }
//
//    }
//
//    public static let herbivorous = Diet(.herbivorous)
//    public static let carnivorous = Diet(.carnivorous)
//    public static let omnivorous  = Diet(.omnivorous)
//
//    public static var allCases: [Diet] { Option.cases.map(\.diet) }
//
//    // Equality based on value semantics
//    public override func isEqual(_ object: Any?) -> Bool {
//        guard let other = object as? Diet else { return false }
//        return self.value == other.value
//    }
//
//    // Hash consistent with isEqual
//    public override var hash: Int {
//        return value.hashValue
//    }
//
//    // Optional: keep a Swift == that matches isEqual
//    public static func == (lhs: Diet, rhs: Diet) -> Bool {
//        lhs.value == rhs.value
//    }
//
//    public let value: String
//
//    private init(_ option: Option) {
//        self.value = option.rawValue
//    }
//
//    public var id: String { self.value }
//
//}

//public class DietTransformer: ValueTransformer {
//
//    public static var Name: String { String(describing: Self.self) }
//
//    public override func transformedValue(_ value: Any?) -> Any? {
//        guard let value = value as? Diet else { return nil }
//        // Convert the custom object to Data
//        do {
//            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
//        } catch {
//            print("Error archiving color: \(error)")
//            return nil
//        }
//    }
//
//    public override func reverseTransformedValue(_ value: Any?) -> Any? {
//        guard let data = value as? Data else { return nil }
//        // Convert Data back to the custom object
//        do {
//            return try NSKeyedUnarchiver.unarchivedObject(ofClass: Diet.self, from: data)
//        } catch {
//            print("Error unarchiving color: \(error)")
//            return nil
//        }
//    }
//
//    // Required for Core Data compatibility
//    public override class func transformedValueClass() -> AnyClass {
//        return Diet.self
//    }
//
//    public override class func allowsReverseTransformation() -> Bool {
//        return true
//    }
//
//}

