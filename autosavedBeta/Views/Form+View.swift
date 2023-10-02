//
//  Form+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import SwiftUI

struct FormView: View {
    
    let header: String
    let message: String?
    
    init(_ header: String, _ message: String?) {
        self.header = header
        self.message = message
    }
    
    init(_ header: String, _ message: UUID) {
        self.init(header, message.uuidString)
    }
    
    init(_ header: String, _ message: Int) {
        self.init(header, message.description)
    }
    
    init(_ header: String, _ message: Bool) {
        self.init(header, message.description)
    }
    
    
//    init(_ header: String, _ message: Any) {
//        self.header = header
//        self.message = String(describing: message)
//    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text(self.header)
            Spacer()
            Text(self.message.toString)
        }
    }
}
