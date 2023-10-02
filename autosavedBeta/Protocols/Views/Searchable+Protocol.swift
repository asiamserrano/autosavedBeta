//
//  Searchable+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation

public protocol SearchableViewProtocol: StandardViewProtocol {
    
    var search: String { get }
    
}

extension SearchableViewProtocol {
    
    var key: String {
        self.search.canonicalized
    }
    
    var value: String {
        self.search.trimmed
    }
    
//    func validate(_ input: String) -> Bool {
//
//        var nm: String {
//            if let int: Int = Int(input) { return int.description }
//            else { return input }
//        }
//
//        return self.key.isEmpty ? true : self.key.count > 1 ? nm.stripped.contains(self.key) :
//        nm.components(separatedBy: " ").map { $0.stripped }.contains(self.key) ||
//        nm.stripped.starts(with: self.key)
//    }
    
}
