//
//  Hide+Modifier.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import SwiftUI

struct HideModifier: ViewModifier {
    
    let isHidden: Bool
    
    init(_ hidden: Bool) {
        self.isHidden = hidden
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(self.isHidden ? 0 : 1)
            .disabled(self.isHidden)
    }
    
}
