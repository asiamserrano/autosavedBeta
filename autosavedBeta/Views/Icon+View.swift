//
//  Icon+View.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import SwiftUI

public struct IconView: View {
    
    private static let defaultSize: CGFloat = 15

    private var iconName: String
    private var iconColor: Color
    private var iconWidth: CGFloat
    private var iconHeight: CGFloat
    
    public init(_ n: String, _ w: CGFloat?, _ h: CGFloat?,  _ c: Color?) {
        self.iconName = n
        self.iconColor = c ?? appSecondaryColor
        self.iconWidth = w ?? Self.defaultSize
        self.iconHeight = h ?? Self.defaultSize
    }
    
    public init(_ n: String) {
        self = .init(n, nil, nil, nil)
    }
    
    public init(_ n: String, _ c: Color) {
        self = .init(n, nil, nil, c)
    }
    
    public init(_ n: String, _ c: Color, _ h: CGFloat) {
        self = .init(n, h, h, c)
    }
    
    public init(_ n: String, _ w: CGFloat, _ h: CGFloat) {
        self = .init(n, w, h, nil)
    }
    
    public init(_ n: String, _ c: CGFloat) {
        self = .init(n, c, c, nil)
    }

    public var body: some View {
        Image(systemName: self.iconName)
            .resizable()
            .scaledToFit()
            .frame(width: self.iconWidth, height: self.iconHeight)
            .foregroundColor(self.iconColor)
    }
    
}
