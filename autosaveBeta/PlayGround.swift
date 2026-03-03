////
////  PlayGround.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 2/24/26.
////
//

import SwiftUI
import Core

struct PlayGroundView: View {
    
    typealias Strings = any Collection<String>
//    
//    
//    
//    let strings: [Strings] = [
//        ["a", "b", "c"],
//        ["  a", "b  ", "    c "],
//        Set<String>.init(arrayLiteral: "a", "b", "c"),
//        Set<String>.init(arrayLiteral: "c", "a", "b"),
//        ["   b", "  c  ", "a   "],
//    ]
    
//    @State var input: Input.Builder = .init(.series, "Grand Theft Auto")
    
    
//    let strings: [Strings] = [
//        ["a"], Set<String>(["b", "c"]), ["d"], Set<String>(["e", "f", "g"]), ["h", "i", "j", "k", "l"], Set<String>(["m", "n", "o", "p"]), ["q"]
//    ]
//    
//    var flattened: [String] {
//        self.strings.flatMap(\.ordered)
//    }
//    
//    var asString: String {
//        self.flattened.joined(separator: ", ")
//    }
    
    
    var dates: [Date] {
        10.map {
            .fromDateComponents(2026, 1, $0 + 1)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Date to Int") {
                    ForEach(0..<dates.count, id:\.self) {
                        let date = dates[$0]
                        Text("date: \(date.dashless)")
                        Text("uint8: \(date.uInt8)")
                    }
                }
            }
            .toolbar {
                
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button("Random") {
//                        self.input = .init(.random, .random)
//                    }
//                })
                
            }
        }
    }

}

#Preview {
    PlayGroundView()
}


//
//extension UUID {
//    
//    private static func v3(original: UUID) throws -> UUID? {
//        // 1) Get namespace bytes in network byte order (big-endian)
//        var ns = original.uuid
//        var bytes = withUnsafeBytes(of: &ns) { Data($0) }
//        
//        //        // 2) Append name bytes
//        //        bytes.append(data)
//        
//        // 3) MD5 hash
//        let digest = Insecure.MD5.hash(data: bytes)
//        var hashBytes = Data(digest)
//        precondition(hashBytes.count == 16)
//        
//        // 4) Set version (bits 12-15) to 3
//        hashBytes[6] = (hashBytes[6] & 0x0F) | 0x30
//        // 5) Set variant (10xx xxxx)
//        hashBytes[8] = (hashBytes[8] & 0x3F) | 0x80
//        
//        // 6) Build UUID from bytes
//        let uuid = hashBytes.withUnsafeBytes { rawPtr -> uuid_t in
//            let ptr = rawPtr.bindMemory(to: UInt8.self).baseAddress!
//            return (ptr[0], ptr[1], ptr[2], ptr[3], ptr[4], ptr[5], ptr[6], ptr[7], ptr[8], ptr[9], ptr[10], ptr[11], ptr[12], ptr[13], ptr[14], ptr[15])
//        }
//        return UUID(uuid: uuid)
//        
//    }
//    
//    private static func uuidFromString_md5(_ s: String) -> UUID {
//        // 1) Hash the UTF-8 bytes of the string
//        let digest = Insecure.MD5.hash(data: Data(s.utf8))
//        var bytes = Data(digest) // 16 bytes
//
//        // 2) Optionally force v3 version/variant bits (RFC 4122)
//        bytes[6] = (bytes[6] & 0x0F) | 0x30  // version = 3
//        bytes[8] = (bytes[8] & 0x3F) | 0x80  // variant = 10xx xxxx
//        
//        
//
//        // 3) Build UUID from the 16 bytes
//        let uuid = bytes.withUnsafeBytes { rawPtr -> uuid_t in
//            let p = rawPtr.bindMemory(to: UInt8.self).baseAddress!
//            return (p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
//                    p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
//        }
//        return UUID(uuid: uuid)
//    }
//    
//    var asV3: Self? {
//        try? .v3(original: self)
//    }
//    
//}
//
//var uuids: [String] = [
//    "00000000-0000-0000-0000-000000000000",
//    "00000000-0000-3000-8000-000000000000",
//    "ffffffff-ffff-3fff-bfff-ffffffffffff",
//    "ffffffff-ffff-3fff-8fff-ffffffffffff"
//]
//
