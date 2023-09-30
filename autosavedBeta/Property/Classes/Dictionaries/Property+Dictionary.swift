//
//  Property+Dictionary.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/29/23.
//

import Foundation

public class PropertyDictionary: DictionaryProtocol {
    
    @Published public private (set) var input: InputDictionary = .init()
    @Published public private (set) var mode: ModeDictionary = .init()
    @Published public private (set) var platform: PlatformDictionary = .init()
    
    public required init() { }
    
    public required init(_ nsset: NSSet?) {
        self.input = .init(nsset)
        self.mode = .init(nsset)
        self.platform = .init(nsset)
    }
    
    public var builders: [any BuilderProtocol] {
        [
            self.input.builders,
            self.mode.builders,
            self.platform.builders
        ].flatMap { $0 }
    }
    
}

public extension PropertyDictionary {
    
    func setID(_ id: ID) -> Void {
        self.input = id
    }
    
    func setMD(_ md: MD) -> Void {
        self.mode = md
    }
    
    func setPD(_ pd: PD) -> Void {
        self.platform = pd
    }
    
    func equals(_ o: PropertyDictionary, _ hash: HashEnum) -> Bool {
        self.input.equals(o.input, hash) &&
        self.mode.equals(o.mode) &&
        self.platform.equals(o.platform)
    }
    
    
    
}
