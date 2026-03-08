//
//  PlayGround.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/3/26.
//

import SwiftUI
import Core

class RandomizedArray<T> {
    
    private let array: [T]
    private var tracker: [Int: Bool]
        
    public init(_ array: [T]) {
        self.array = array
        self.tracker = .init(uniqueKeysWithValues: array.indices.map { ($0, true) })
    }
    
    public func get() -> T {
        let index = Int.random(in: 0..<count)
        if let available = tracker[index], available {
            let t = array[index]
            self.tracker[index] = false
            return t
        } else { return get() }
    }
    
    public var count: Int { self.array.count }
    public var isNotEmpty: Bool { self.count > 0 }
    
}

struct PlayGround: View {
//    
//    var maxInt: Int { Int.max }
//    
////    var date: Date { .fromDateComponents(1980, 10, 13) }
//    
//    var dates: [Date] { 10.map { .random } + [.now] }
//    
//    var ints: [Int] {
//        [0, 1, 10, 63, 101, 244, 254, 255, 256, 500, 29393, 76500, 193239, 3039383, 91283023, 1738393833323, Int.max]
//    }
//    
//    var string: String { .random }
 
    var body: some View {
        NavigationStack {
            Form {
                ForEach(0..<25, id:\.self) { _ in
                    Text(String.random)
                }
            }
        }
    }
    
}

#Preview {
    PlayGround()
}
