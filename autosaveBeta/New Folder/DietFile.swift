////
////  DietFile.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/23/26.
////
//
//import Foundation
//import Core
//import SwiftUI
//import SwiftData
//
//@Model
//public final class Diet: IterableModel, Iterable {
//    
//    public static func insertPredicate(_ uuid: UUID) -> Predicate<Diet> {
//        #Predicate<Diet> { $0.uuid == uuid }
//    }
//    
//    public static let herbivorous = Diet(.herbivorous)
//    public static let carnivorous = Diet(.carnivorous)
//    public static let omnivorous  = Diet(.omnivorous)
//    
//    public static var cases: [Diet] { Option.allCases.map(\.diet) }
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
//    public private(set) var uuid: UUID
//    //    public private(set) var optionId: String
//    public private(set) var value: String
//    
//    @Relationship(inverse: \Dog.diet)
//    public var dogs: [Dog]
//    
//    private init(_ option: Option) {
//        self.uuid = .v3(enumerable: option, for: Self.self)
//        self.value = option.rawValue
//        self.dogs = .defaultValue
//    }
//    
//    public var toString: String {
//        "\(self.value) (\(self.dogs.count))"
//    }
//    
//}
//
//struct DietView: ModelContextView {
//    
//    @Environment(\.modelContext) public var modelContext
//
//    @Query private var diets: [Diet]
//    
//    @State var diet: Diet? = nil
//    
//    var body: some View {
//        
//        /*
//         PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID(0xbeaad62ef4089cf6 <x-coredata://9439C931-590D-4AE6-B1B5-119EC0671D75/Breed/p1>)))
//         */
//        
//        NavigationStack {
//            Form {
//                IterableModelView("Diets", self.diets)
//                
//                if let diet = self.diet {
//                    Section("Recently Added") {
//                        SpacedLabel("uuid", diet.uuid.uuidString)
//                        SpacedLabel("value", diet.value)
//                        
//                        ForEach(getIDParts(diet), id:\.self) {
//                            Text($0)
//                        }
//                        
////                        SpacedLabel("id", getID(diet))
//                    }
//                }
//                
//            }
//            .toolbar {
//                
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Add") {
////                        if let result = self.modelContext.maybeSave(Diet.random) {
////                            print(getIDParts(result))
////                            self.diet = result
////                        } else {
////                            self.diet = nil
////                        }
//                        
//                        if let result: Diet = self.modelContext.insertWithPredicate(Diet.random) {
//                            print(getIDParts(result))
//                            self.diet = result
//                        } else {
//                            self.diet = nil
//                        }
//                        
////                        let result = self.insert(Diet.random)
////                        print(getIDParts(result))
////                        self.diet = result
//                    }
//                })
//                
//            }
//        }
//                
//    }
//    
//    private func getIDParts<T: PersistentModel>(_ t: T) -> [String] {
//        let id = "\(t.id)"
//        return id.replacingOccurrences("PersistentIdentifier(id: SwiftData.PersistentIdentifier.ID(backing: SwiftData.PersistentIdentifier.PersistentIdentifierBacking.managedObjectID")
//            .replacingOccurrences("(").replacingOccurrences(")").replacingOccurrences("<x-coredata://").replacingOccurrences(">").replacingOccurrences(of: "/", with: " ").split(separator: " ").map { String($0) }
//    }
//    
//    @ViewBuilder
//    private func IterableModelView<T: IterableModel> (_ string: String, _ models: [T]) -> some View {
//        Section(string) {
//            ForEach(models) {
//                Text($0.value)
//            }
//        }
//    }
//
//    
//}
//
//#Preview {
//    DietView()
//        .modelContainer(.forType(Diet.self))
//}
