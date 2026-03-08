////
////  DogFile.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/23/26.
////
//
//import Foundation
//import Core
//import SwiftData
//
//@Model
//public final class Dog: Animal {
//    
//    public private(set) var name: String
//    public private(set) var breed: Breed
//    public private(set) var diet: Diet
//    
//    public required init(name: String, breed: Breed) {
//        self.name = name
//        self.breed = breed
//        self.diet = .omnivorous
//    }
//    
//    public convenience init(_ initializer: Initializer) {
//        switch initializer {
//        case .defaultValue:
//            self.init(name: .defaultValue, breed: .defaultValue)
//        case .random:
//            self.init(name: .random, breed: .random)
//        }
//    }
//    
//    public var toString: String {
//        "\(self.name) (\(self.breed.value))"
//    }
//    
//}
