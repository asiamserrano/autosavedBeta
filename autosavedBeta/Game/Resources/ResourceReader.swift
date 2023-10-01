//
//  ResourceReader.swift
//  autosavedDev
//
//  Created by Asia Michelle Serrano on 9/13/23.
//

import Foundation

public class ResourceReader {
    
    enum Files: String {
        case series = "series.txt"
        case image = "image.txt"
        case genre = "genre.txt"
    }
    
    static func readString(_ f: Files) -> String {
        let val: String = f.rawValue
        do {
            let bundlePath: String = Bundle.main.path(forResource: val, ofType: nil) ?? .init()
            return try String(contentsOfFile: bundlePath).trimmed
        } catch {
            fatalError("Cannot find resource: \(val)")
        }
    }
    
    static func readArray(_ f: Files) -> [String] {
        Self.readString(f).split(separator: "\n").map { $0.description }
    }
    
}
