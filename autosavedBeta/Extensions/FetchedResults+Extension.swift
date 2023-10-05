//
//  FetchedResults+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/5/23.
//

import Foundation
import SwiftUI

extension FetchedResults {
    
    public var results: [Element] { self.map { $0 } }
    
}
