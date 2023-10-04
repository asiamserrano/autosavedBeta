//
//  Closeable+Protocol.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/1/23.
//

import Foundation
import SwiftUI

public protocol CloseableProtocol: StandardViewProtocol {
    
    var presentationMode: Binding<PresentationMode> { get }
    var dismiss: Bool { get set }
    
}

extension CloseableProtocol {
    
    public func close(_ bool: Bool) -> Void {
        if bool { self.close() }
    }
    
    public func close() -> Void {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
