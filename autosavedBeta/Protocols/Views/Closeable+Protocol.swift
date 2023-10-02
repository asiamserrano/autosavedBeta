//
//  Closeable+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/1/23.
//

import Foundation
import SwiftUI

public protocol CloseableProtocol: View {
    
    var presentationMode: Binding<PresentationMode> { get }
    var close: Bool { get set }
}

extension CloseableProtocol {
    
    public func closed(_ bool: Bool) -> Void {
        if bool {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
