////
////  String+Dictionary.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////
//
//import Foundation
//
//public typealias SD = StringDictionary
//
//public class StringDictionary: ObservableObject {
//    
//    public typealias Map = [String: String]
//    public typealias Arr = [String]
//    
//    @Published private var map: Map = .init()
//    
//    public init() { }
//    
//    public init(_ arr: Arr) {
//        self.map = .init(uniqueKeysWithValues: arr.map{ ($0.canonicalized, $0.trimmed) })
//    }
//    
//    public init(_ str: String) {
//        self.map = [str.canonicalized: str.trimmed]
//    }
//    
//    public var keys: Arr {
//        self.map.keys.sorted()
//    }
//    
//    public var values: Arr {
//        Set(self.map.values).sorted()
//    }
//    
//}
//
//public extension SD {
//    
//    func put(_ str: String) -> Self {
//        self.map[str.canonicalized] = str.trimmed
//        return self
//    }
//    
//    func remove(_ str: String) -> Self {
//        self.map[str.canonicalized] = nil
//        return self
//    }
//    
//    func get(_ key: String) -> String? {
//        self.map[key]
//    }
//    
//    func equals(_ other: SD, _ hash: HashEnum) -> Bool {
//        switch hash {
//        case .key: return self.keys == other.keys
//        case .value: return self.values == other.values
//        }
//    }
//    
//    func createBuilders(_ input: InputEnum) -> [any BuilderProtocol] {
//        self.keys.map { InputBuilder(input, self.get($0)!) }
//    }
//    
////    func build(_ con: Context, _ input: InputEnum) -> [Property] {
////        self.keys.map { con.fetchProperty(.init(input, self.get($0))) }
////    }
//    
//}
