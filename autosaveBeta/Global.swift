//
//  Global.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 3/6/26.
//

import Foundation
import Core

public let PREVIEW_STORES_DIR_PATH = "/Users/asiaserrano/xcode/autosaveBeta/PreviewStores"

public let NAMES_FILE_PATH = "/Users/asiaserrano/xcode/autosaveBeta/names.txt"

//public func loadFileAsStrings(filePath: String) -> [String] {
//    do {
//        let fileURL = URL(fileURLWithPath: filePath)
//        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
//        let lines = fileContents.components(separatedBy: CharacterSet.newlines)
//        return lines.filter(\.isNotEmpty)
//    } catch {
//        print("Unable to load file '\(filePath)' with error: \(error)")
//        return .defaultValue
//    }
//}
