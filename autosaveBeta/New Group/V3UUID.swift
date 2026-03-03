//
//  V3UUID.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/25/26.
//

import Foundation
import CryptoKit
import Core

public typealias V3UUIDNamespace = V3UUID.Namespace
public typealias V3UUIDNamespaceProviding = V3UUID.Namespace.Providing

public struct V3UUID {
    
    private static let defaultValueUUIDString = "00000000-0000-0000-0000-000000000000"
    private static let enumerableUUIDString = "AEA10A85-56DA-44BE-A0C5-67BC55E59776"
    private static let inputBuilderUUIDString = "91B2D41E-8990-427D-9E55-6310918C9D39"
    private static let persistentUUIDString = "A058A51B-F362-42BE-92AA-988C8ED395F3"
            
    public struct Namespace {
        
        public protocol Providing: SelfTypeProviding, ClassNameProviding, UUID.Providing {}
        
        private struct UUIDString {
            
            public static let defaultValue = UUIDString(rawValue: defaultValueUUIDString)
            public static let enumerable = UUIDString(rawValue: enumerableUUIDString)
            public static let persistent = UUIDString(rawValue: persistentUUIDString)
            
            public enum Registered: String {
                case inputBuilder
                
                var rawValue: String {
                    switch self {
                    case .inputBuilder:
                        return inputBuilderUUIDString
                    }
                }
                
                var namespace: Namespace {
                    let uuidString: UUIDString = .init(rawValue: self.rawValue)
                    return .init(uuidString)
                }
                
            }
            
            public let rawValue: String
            
        }
        
        private static let defaultValue = Namespace(.defaultValue)
        private static let enumerable = Namespace(.enumerable)
        private static let persistent = Namespace(.persistent)
        
        private static let registry: [Element: UUIDString.Registered] = [
            Element(Input.Builder.self) : .inputBuilder
        ]
        
        public static func getNamespaceForProvider<T: Providing>(provider t: T.Type) -> Self {
            if let registered = Self.registry[Element(t)] {
                return registered.namespace
            } else {
                let message = "Type '\(t.className)' has not been registered."
                print(message)
                fatalError(message)
            }
        }
        
        fileprivate let uuidTuple: UUID.Tuple
        public let uuidString: String
        
        public init<T: Enumerable>(enumerable t: T.Type) {
            self.init(.enumerable, t)
        }
        
        public init<T: PersistentModelProtocol>(persistent t: T.Type) {
            self.init(.persistent, t)
        }
        
        private init<T: ClassNameProviding>(_ ns: Namespace, _ t: T.Type) {
            let v3: V3UUID = .init(namespace: ns, name: [t.className])
            self.init(uuid: v3.uuid)
        }
        
//        public func uuid(mask: Int? = nil, _ strings: String...) -> UUID {
//            let v3: V3UUID = .init(namespace: self, name: strings, version: mask?.uInt8)
//            return v3.uuid
//        }
        
        public func uuid(title: String, release: Date) -> UUID {
            let strings = [ title.canonicalized ]
            let mask = release.uInt8
            print("Mask: \(mask) | strings: \(strings)")
            return uuid(strings, mask)
        }
        
        public func uuid<T:Enumerable>(enumerable t: T, _ strings: String...) -> UUID {
//            print("strings before: \(strings.description)")
            let mask = t.index.uInt8
            let strings = strings.ordered.withHead(t.id)
//            print("strings after: \(strings.description)")
            return uuid(strings, mask)
        }
        
        private func uuid(_ strings: [String], _ mask: UInt8) -> UUID {
            V3UUID(namespace: self, name: strings, version: mask).uuid
        }
                
    }
    
    private let uuid: UUID
    
    private init(namespace: Namespace, name: any Collection<String>, version: UInt8? = nil) {
        // 1) Get namespace bytes in network byte order (big-endian)
        var ns = namespace.uuidTuple
        var dataBytes = withUnsafeBytes(of: &ns) { Data($0) }
        
        // 2) Append name bytes
        dataBytes.append(name.data)
        
        // 1) Hash the UTF-8 bytes of the string
        let digest = Insecure.MD5.hash(data: dataBytes)
        var bytes = Data(digest) // 16 bytes
        
        // 3) Use v3 version/variant bits (RFC 4122)
        let version = version ?? .defaultValue
        bytes[6] = (bytes[6] & 0x0F) | version  // version
        bytes[8] = (bytes[8] & 0x3F) | 0x80  // variant = 10xx xxxx
        
        // 4) Build UUID from the 16 bytes
        let uuidTuple = bytes.withUnsafeBytes { rawPtr -> uuid_t in
            let p = rawPtr.bindMemory(to: UInt8.self).baseAddress!
            return (p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
                    p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
        }
        
        let uuid: UUID = .init(uuid: uuidTuple)
        self.uuid = uuid
    }

}

extension V3UUID.Namespace {
        
    private init(uuid: UUID) {
        self.uuidTuple = uuid.uuid
        self.uuidString = uuid.uuidString
    }
    
    private init(_ uuidString: UUIDString) {
        if let uuid: UUID = .init(uuidString: uuidString.rawValue) {
            self.init(uuid: uuid)
        } else {
            let error = "Error casting uuidString '\(uuidString)' to UUID Namespace"
            print(error)
            fatalError(error)
        }
    }
    
    private struct Element: Hashable {
        let className: String
        
        init<T: ClassNameProviding>(_ t: T.Type) {
            self.className = t.className
        }
    }

}

extension V3UUIDNamespaceProviding {
    
    public typealias Namespace = V3UUIDNamespace
    
    public static var namespace: Namespace {
        .getNamespaceForProvider(provider: Self.self)
    }
    
    public var namespace: Namespace {
        Self.namespace
    }
    
}
