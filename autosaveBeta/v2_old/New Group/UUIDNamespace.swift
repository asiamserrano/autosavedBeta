//////
//////  UUIDNamespace.swift
//////  autosaveBeta
//////
//////  Created by Asia Serrano on 2/25/26.
//////
////
//import Foundation
//import Core
//import SwiftUI
//import CryptoKit
//
//public final class UUIDNamespace {
//    
//    public typealias Namespace = UUIDNamespace
//    
//    public static let defaultValue: Namespace = .init(uuidString: .defaultValue)
//    
//    private static let enumerable: Namespace = .init(uuidString: .enumerable)
//    
//    private static let registered: [String: UUIDString] = [
//        Input.Builder.className : .input
//    ]
//    
////    public static func getFromRegistry<T: ClassNameProviding>(for t: T.Type) -> Namespace {
////        
////    }
//    
//    private enum UUIDString: String {
//        case defaultValue, enumerable, input
//        
//        var rawValue: String {
//            switch self {
//            case .defaultValue:
//                return "00000000-0000-0000-0000-000000000000"
//            case .enumerable:
//                return "AEA10A85-56DA-44BE-A0C5-67BC55E59776"
//            case .input:
//                return "91B2D41E-8990-427D-9E55-6310918C9D39"
//            }
//        }
//        
//    }
//
//    public private(set) var uuid: UUID
//    
//    private init(uuid: UUID) {
//        self.uuid = uuid
//    }
//    
//    private convenience init(uuidString: UUIDString) {
//        if let uuid: UUID = .init(uuidString: uuidString.rawValue) {
//            self.init(uuid: uuid)
//        } else {
//            let error = "Error casting uuidString '\(uuidString)' to UUID Namespace"
//            print(error)
//            fatalError(error)
//        }
//    }
//    
//    public convenience init<T: Enumerable>(enumerable t: T.Type) {
//        let uuid: UUID = .init(namespace: .enumerable, t.className)
//        self.init(uuid: uuid)
//    }
////    
////    public convenience init(input builder: Input.Builder) {
////        let namespace: Namespace = .input
////        let uuid: UUID = .init(namespace: namespace, t.className)
////        self.init(uuid: uuid)
////    }
//    
//    
//    public func buildUUID(mask: Int? = nil, _ strings: String...) -> UUID {
//        .init(namespace: self, mask: mask, collection: strings)
//    }
//    
//}
//
//fileprivate extension UUID {
//    
//    typealias N = UUIDNamespace.Namespace
//    
//    private init(namespace: N? = nil, name: Data? = nil, version: UInt8? = nil) {
////        let name = name ?? .init()
////        let version = version ?? .defaultValue
////        let namespace = namespace ?? .defaultValue
////        
////        // 1) Get namespace bytes in network byte order (big-endian)
////        var ns = namespace.uuidTuple
////        var dataBytes = withUnsafeBytes(of: &ns) { Data($0) }
////        
////        // 2) Append name bytes
////        dataBytes.append(name)
////        
////        // 1) Hash the UTF-8 bytes of the string
////        let digest = Insecure.MD5.hash(data: dataBytes)
////        var bytes = Data(digest) // 16 bytes
////
////        // 3) Use v3 version/variant bits (RFC 4122)
////        bytes[6] = (bytes[6] & 0x0F) | version  // version
////        bytes[8] = (bytes[8] & 0x3F) | 0x80  // variant = 10xx xxxx
////
////        // 4) Build UUID from the 16 bytes
////        let uuid = bytes.withUnsafeBytes { rawPtr -> uuid_t in
////            let p = rawPtr.bindMemory(to: UInt8.self).baseAddress!
////            return (p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
////                    p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
////        }
////        
////        self = .init(uuid: uuid)
//        self = .defaultValue
//    }
//    
//    init<S: Collection>(namespace ns: N, mask: Int? = nil, collection s: S) where S.Element == String {
//        let mask = (mask ?? s.count).uInt8
//        let data = s.data
//        self.init(namespace: ns, name: data, version: mask)
//    }
//    
//    init(namespace ns: N, mask: Int? = nil, _ strings: String...) {
//        self.init(namespace: ns, mask: mask, collection: strings)
//    }
//    
//}
//
////private extension UUIDNamespace {
////    
////    struct Registry {
////        
////        
////        
////    }
////    
////}
//
//
////extension UUID.Namespace {
////    
////    public static let input: UUID.Namespace = .init(uuidString: "91B2D41E-8990-427D-9E55-6310918C9D39")
////    
////}
////
////public protocol FoobarProtocol {}
////
////extension Enumerable {
////    
////    
////    
////    
////}
//
//
////struct EnumerableUUIDView: View {
////    var body: some View {
////        SectionView(Mode.Enum.self)
//////        SectionView(Format.Builder.self)
////    }
////    
////    
//////    @ViewBuilder
//////    private func SectionView<T: Enumerable>(_ t: T.Type) -> some View {
//////        Section("\(t.className)\n\(t.namespace.uuidString)") {
//////            ForEach(t.cases) { c in
//////                Text("\(c.rawValue)\n\(c.uuid.uuidString)")
//////            }
//////        }
//////    }
////    
////}
////
////#Preview {
////    Previewer { EnumerableUUIDView() }
////}
