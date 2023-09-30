////
////  Platform+Dictionary.swift
////  autosavedBeta
////
////  Created by Asia Serrano on 9/29/23.
////
//
//import Foundation
//
//public typealias PD = PlatformDictionary
//
//public class PlatformDictionary: DictionaryProtocol {
//    
//    public typealias Map = [PlatformEnum: Values]
////    public typealias Inputs = [PropertyEnum]
//    public typealias Values = [FormatEnum]
//    
//    @Published private var map: Map = .init()
//    
//    public required init() { }
//    
//    public required convenience init(_ ns: NSSet?) {
//        self.init()
//        if let nsset: NSSet = ns {
//            let properties: [Property] = Property.filter(nsset, .platform)
//            let builders: [PlatformBuilder] = properties.map(PlatformBuilder.init)
//            builders.forEach { self.put($0.platformEnum, $0.formatEnum) }
//        }
//    }
//    
//    public var keys: [PlatformEnum] {
//        self.map.keys.sorted()
//    }
//    
//    public var builders: [any BuilderProtocol] {
//        self.keys.flatMap { pe in self.get(pe).map { PlatformBuilder(pe, $0) } }
//    }
//    
//}
//
//public extension PD {
//    
//    func put(_ p: PlatformEnum, _ f: FormatEnum) -> Void {
//        self.map[p] = Set(self.get(p) + [f]).sorted()
//    }
//    
//    func remove(_ p: PlatformEnum) -> Void {
//        self.map[p] = nil
//    }
//    
//    func remove(_ p: PlatformEnum, _ f: FormatEnum) -> Void {
//        self.map[p] = self.get(p).filter { $0 != f }
//    }
//    
//    func get(_ p: PlatformEnum) -> Values {
//        self.map[p]?.sorted() ?? .init()
//    }
//    
//    func equals(_ o: PD) -> Bool {
//        self.keys == o.keys ? self.keys.allSatisfy { self.get($0) == o.get($0) } : false
//    }
//    
//    func contains(_ p: PlatformEnum, _ f: FormatEnum) -> Bool {
//        self.get(p).contains(f)
//    }
//    
//    
//}
