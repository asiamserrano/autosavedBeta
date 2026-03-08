////
////  BreedFile.swift
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
//public final class Breed: IterableModel, Iterable {
//    
//    public static func insertPredicate(_ uuid: UUID) -> Predicate<Breed> {
//        #Predicate<Breed> { $0.uuid == uuid }
//    }
//    
//    public static let boston_terrier = Breed(.boston_terrier, "Boston Terrier")
//    public static let vizsla = Breed(.vizsla, "Vizsla")
//    public static let rhodesian_ridgeback = Breed(.rhodesian_ridgeback, "Rhodesian Ridgeback")
//    public static let boxer = Breed(.boxer, "Boxer")
//    public static let bulldog = Breed(.bulldog, "Bulldog")
//    public static let german_shorthaired_pointer = Breed(.german_shorthaired_pointer, "German Shorthaired Pointer")
//    public static let bernese_mountain_dog = Breed(.bernese_mountain_dog, "Bernese Mountain Dog")
//    public static let doberman_pinscher = Breed(.doberman_pinscher, "Doberman Pinscher")
//    public static let yorkshire_terrier = Breed(.yorkshire_terrier, "Yorkshire Terrier")
//    public static let french_bulldog = Breed(.french_bulldog, "French Bulldog")
//    public static let australian_shepherd = Breed(.australian_shepherd, "Australian Shepherd")
//    public static let german_wirehaired_pointer = Breed(.german_wirehaired_pointer, "German Wirehaired Pointer")
//    public static let beagle = Breed(.beagle, "Beagle")
//    public static let pug = Breed(.pug, "Pug")
//    public static let australian_cattle_dog = Breed(.australian_cattle_dog, "Australian Cattle Dog")
//    public static let mastiff = Breed(.mastiff, "Mastiff")
//    public static let rottweiler = Breed(.rottweiler, "Rottweiler")
//    public static let miniature_schnauzer = Breed(.miniature_schnauzer, "Miniature Schnauzer")
//    public static let great_dane = Breed(.great_dane, "Great Dane")
//    public static let west_highland_white_terrier = Breed(.west_highland_white_terrier, "West Highland White Terrier")
//    public static let pomeranian = Breed(.pomeranian, "Pomeranian")
//    public static let golden_retriever = Breed(.golden_retriever, "Golden Retriever")
//    public static let newfoundland = Breed(.newfoundland, "Newfoundland")
//    public static let cane_corso = Breed(.cane_corso, "Cane Corso")
//    public static let cocker_spaniel = Breed(.cocker_spaniel, "Cocker Spaniel")
//    public static let chihuahua = Breed(.chihuahua, "Chihuahua")
//    public static let labrador_retriever = Breed(.labrador_retriever, "Labrador Retriever")
//    public static let german_shepherd_dog = Breed(.german_shepherd_dog, "German Shepherd Dog")
//    public static let brittany_spaniel = Breed(.brittany_spaniel, "Brittany Spaniel")
//    public static let dachshund = Breed(.dachshund, "Dachshund")
//    public static let english_springer_spaniel = Breed(.english_springer_spaniel, "English Springer Spaniel")
//    public static let shetland_sheepdog = Breed(.shetland_sheepdog, "Shetland Sheepdog")
//    public static let border_collie = Breed(.border_collie, "Border Collie")
//    public static let havanese = Breed(.havanese, "Havanese")
//    public static let shih_tzu = Breed(.shih_tzu, "Shih Tzu")
//    public static let cavalier_king_charles_spaniel = Breed(.cavalier_king_charles_spaniel, "Cavalier King Charles Spaniel")
//    public static let pembroke_welsh_corgi = Breed(.pembroke_welsh_corgi, "Pembroke Welsh Corgi")
//    public static let poodle = Breed(.poodle, "Poodle")
//    public static let siberian_husky = Breed(.siberian_husky, "Siberian Husky")
//    
//    public static var cases: [Breed] {
//        [
//            .boston_terrier, .vizsla, .rhodesian_ridgeback, .boxer, .bulldog, .german_shorthaired_pointer, .bernese_mountain_dog, .doberman_pinscher, .yorkshire_terrier, .french_bulldog, .australian_shepherd, .german_wirehaired_pointer, .beagle, .pug, .australian_cattle_dog, .mastiff, .rottweiler, .miniature_schnauzer, .great_dane, .west_highland_white_terrier, .pomeranian, .golden_retriever, .newfoundland, .cane_corso, .cocker_spaniel, .chihuahua, .labrador_retriever, .german_shepherd_dog, .brittany_spaniel, .dachshund, .english_springer_spaniel, .shetland_sheepdog, .border_collie, .havanese, .shih_tzu, .cavalier_king_charles_spaniel, .pembroke_welsh_corgi, .poodle, .siberian_husky
//        ]
//    }
//    
//    private enum Option: Enumerable {
//        case boston_terrier, vizsla, rhodesian_ridgeback, boxer, bulldog, german_shorthaired_pointer, bernese_mountain_dog, doberman_pinscher, yorkshire_terrier, french_bulldog, australian_shepherd, german_wirehaired_pointer, beagle, pug, australian_cattle_dog, mastiff, rottweiler, miniature_schnauzer, great_dane, west_highland_white_terrier, pomeranian, golden_retriever, newfoundland, cane_corso, cocker_spaniel, chihuahua, labrador_retriever, german_shepherd_dog, brittany_spaniel, dachshund, english_springer_spaniel, shetland_sheepdog, border_collie, havanese, shih_tzu, cavalier_king_charles_spaniel, pembroke_welsh_corgi, poodle, siberian_husky
//    }
//    
//    @Attribute(.unique)
//    public private(set) var uuid: UUID
//    public private(set) var value: String
//    
//    @Relationship(inverse: \Dog.breed)
//    public var dogs: [Dog]
//    
//    private init(_ option: Option, _ value: String) {
//        self.uuid = .v3(enumerable: option, for: Self.self)
//        self.value = value
//        self.dogs = .defaultValue
//    }
//    
//    public var toString: String {
//        "\(self.value) (\(self.dogs.count))"
//    }
//    
//}
