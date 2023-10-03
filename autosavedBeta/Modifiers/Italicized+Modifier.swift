//
//  Italicized+Modifier.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import Foundation
import SwiftUI

struct ItalicizedModifier: ViewModifier {
    
    let isActive: Bool
    let color: Color
    
    init(_ b: Bool, _ c: Color) {
        self.color = c
        self.isActive = b
    }
    
    func body(content: Content) -> some View {
        content
            .italic(self.isActive)
            .foregroundColor(self.color)
    }
    
}
