//
//  Alert+Object.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/2/23.
//

import Foundation
import SwiftUI

public class AlertObject: ObservableObject {
    
    @Published public var show: Bool = false
    
    private var header: String = .empty
    private var message: String = .empty
    
    public var alert: Alert {
        Alert(title: Text(self.header), message: Text(self.message))
    }
    
    public init() { }
    
    public init(_ msg: String, _ e: AlertEnum) {
        self.header = e.header
        self.message = "\(msg) \(e.message)"
        self.show = true
    }
}
