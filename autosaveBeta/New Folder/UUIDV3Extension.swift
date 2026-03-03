//
//  UUIDV3Extension.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/23/26.
//
import Foundation
import SwiftData
import Core

//extension UUID {
//    
//    public static func v3<T: Enumerable, M: PersistentModel>(enumerable t: T, for model: M.Type) -> UUID {
//        let modelName = String(describing: model)
//        let enumName = String(describing: T.self)
//        let index = t.index.description
//        let className: String = .joined(by: .period, modelName, enumName)
//        let name: String = .joined(by: .pipe, index, className, String(describing: t))
//        let namespace: Namespace = .from(model)
//        return .v3(namespace: namespace, name: name)
//    }
//    
//    public static func v3<T: Enumerable, M: PersistentModel>(enumerable t: T, for model: M.Type, _ str: Str) -> UUID {
//        let modelName = String(describing: model)
//        let enumName = String(describing: T.self)
//        let index = t.index.description
//        let className: String = .joined(by: .period, modelName, enumName)
//        let name: String = .joined(by: .pipe, index, className, String(describing: t), str.id, str.rawValue)
//        let namespace: Namespace = .from(model)
//        return .v3(namespace: namespace, name: name)
//    }
//    
//    public enum Namespace: UUIDNamespace {
//        case app, game, property, platform, attribute, diet, breed
//    }
//    
//}

//
//extension UUID {
//    /// Generates a UUID version 3 (name-based, MD5) per RFC 4122
//    /// - Parameters:
//    ///   - namespace: The namespace UUID (e.g., DNS, URL, OID, X500). You can also use any UUID as a namespace.
//    ///   - name: The name data to hash within the namespace. Commonly UTF-8 bytes of a string.
//    /// - Returns: A UUID with version 3 and RFC 4122 variant set.
//    private static func v3(nsUUID: UUID, data: Data) -> UUID {
//        // 1) Get namespace bytes in network byte order (big-endian)
//        var ns = nsUUID.uuid
//        var bytes = withUnsafeBytes(of: &ns) { Data($0) }
//
//        // 2) Append name bytes
//        bytes.append(data)
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
//    }
//    
//    public static func v3(namespace: Namespace, name: String) -> UUID {
//        .v3(nsUUID: namespace.uuid, data: Data(name.utf8))
//    }
//    
//    public static func v3<T: Enumerable, M: PersistentModel>(enumerable t: T, for model: M.Type) -> UUID {
//        let modelName = String(describing: model)
//        let enumName = String(describing: T.self)
//        let index = t.index.description
//        let className: String = .joined(by: .period, modelName, enumName)
//        let name: String = .joined(by: .pipe, index, className, String(describing: t))
//        let namespace: Namespace = .from(model)
//        return .v3(namespace: namespace, name: name)
//    }
//    
////    public static func v3(separator: Separator, _ strings: String...) -> UUID {
//////        let name: String = .joined(by: separator, strings)
////        let name = strings.joined(separator: separator.rawValue)
////        return .v3(namespace: .app, name: name)
////    }
//
////    /// Convenience overload for string names (UTF-8)
////    static func v3(namespace: UUID, name: String) -> UUID {
////        UUID.v3(namespace: namespace, name: Data(name.utf8))
////    }
//    
////    static func v3(namespace: Namespace, name: String) -> UUID {
////        UUID.v3(namespace: namespace.uuid, name: Data(name.utf8))
////    }
//    
////    /// Initializer for UUID version 3 (name-based, MD5) using Data
////    init(v3 namespace: UUID, name: Data) {
////        self = UUID.v3(namespace: namespace, name: name)
////    }
////
////    /// Initializer for UUID version 3 (name-based, MD5) using String (UTF-8)
////    init(v3 namespace: UUID, name: String) {
////        self = UUID.v3(namespace: namespace, name: name)
////    }
//    
//    public enum Namespace: Enumerable {
//        case app, diet, breed, property
//    }
//    
//}
//
//extension UUID.Namespace {
//    
//    fileprivate static func from<T: PersistentModel>(_ t: T.Type) -> Self {
//        switch true {
//        case t is Diet.Type: return .diet
//        case t is Breed.Type: return .breed
//        case t is Property.Type: return .property
//        default:
//            print("\(t.self) has not been assigned UUID Namespace. Using default.")
//            return .app
//        }
//    }
//    
//    public var uuid: UUID {
//        let i = self.index + 10
//        let uuidString = "6ba7b8\(i.leadingZero)-9dad-11d1-80b4-00c04fd430c8"
//        return .init(uuidString: uuidString)!
//    }
//    
//}
//
////
////    public static func from<T: PersistentModel>(_ t: T.Type) -> Self {
////        switch true {
////        case t is Diet.Type: return .diet
////        case t is Breed.Type: return .breed
////        case t is Property.Type: return .property
////        default:
////            print("\(t.self) has not been assigned UUID Namespace. Using default.")
////            return .app
////        }
////    }
////    
////    public var uuid: UUID {
////        let i = self.index + 10
////        let uuidString = "6ba7b8\(i.leadingZero)-9dad-11d1-80b4-00c04fd430c8"
////        return .init(uuidString: uuidString)!
////    }
////   
////}
