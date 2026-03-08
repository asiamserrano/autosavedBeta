////
////  UUID+Extension.swift
////  autosaveBeta
////
////  Created by Asia Serrano on 3/3/26.
////
//
//import Foundation
//import Core
//import SwiftData
//import CryptoKit
//
//extension UUID {
//    
//    public init<T: ClassNameProviding>(providing t: T.Type, _ date: Date) {
//        let number = DateFormatter.format(date, .number)
//        let sinceReference = String(date.timeIntervalSinceReferenceDate)
//        let since1970 = String(date.timeIntervalSince1970)
//        let mask: UInt8? = Int(date.dashless)?.uInt8
//        self.init(providing: t, version: mask, name: number, sinceReference, since1970)
//    }
//    
//    public init<T: ClassNameProviding>(providing t: T.Type, version: UInt8? = nil, name: String...) {
//        let namespace: UUID = .init(data: [t.className].data)
//        var ns = namespace.uuid
//        var dataBytes = withUnsafeBytes(of: &ns) { Data($0) }
//        dataBytes.append(name.data)
//        self.init(data: dataBytes, version: version)
//    }
//    
////    private init(data string: String, version: UInt8? = nil) {
////        self.init(data: [string].data, version: version)
////    }
//    
//    private init(data dataBytes: Data, version: UInt8? = nil) {
//        let digest = Insecure.MD5.hash(data: dataBytes)
//        var bytes = Data(digest)
//        let version = version ?? .defaultValue
//        bytes[6] = (bytes[6] & 0x0F) | version
//        bytes[8] = (bytes[8] & 0x3F) | 0x80
//        
//        let uuidTuple = bytes.withUnsafeBytes { rawPtr -> uuid_t in
//            let p = rawPtr.bindMemory(to: UInt8.self).baseAddress!
//            return (p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7],
//                    p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
//        }
//        
//        self = .init(uuid: uuidTuple)
//    }
//    
//}
