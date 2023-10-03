//
//  View+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import SwiftUI

public extension View {
    
    @ViewBuilder
    func CheckMarkView(_ str: String, _ bool: Bool) -> some View {
        HStack(alignment: .center) {
            Text(str)
            Spacer()
            IconView("checkmark").hide(!bool)
        }
    }
    
    @ViewBuilder
    func ClearableTextField(_ binding: Binding<String>, keyboard: UIKeyboardType = .alphabet) -> some View {
        HStack(alignment: .center) {
            let text: String = binding.wrappedValue
            
            TextField(text, text: binding, axis: .vertical)
                .keyboardType(keyboard)
                .disableAutocorrection(true)
                .multilineTextAlignment(.leading)
            
            if !text.canonicalized.isEmpty {
                Button(action: {
                    binding.wrappedValue = .init()
                }, label: {
                    IconView("xmark.circle.fill")
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func hide(_ bool: Bool) -> some View {
        modifier(HideModifier(bool))
    }
    
    func italicize(_ bool: Bool, _ color: Color = .black) -> some View {
        modifier(ItalicizedModifier(bool, color))
    }
    
}
