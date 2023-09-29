//
//  Image+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation
import SwiftUI

public extension Image {
    
    init(_ d: Data?) {
        if let data: Data = d, let ui: UIImage = .init(data: data), let _ : Data = ui.pngData() {
            self.init(uiImage: ui)
        } else {
            self.init(systemName: "photo.circle.fill")
        }
    }
    
}
