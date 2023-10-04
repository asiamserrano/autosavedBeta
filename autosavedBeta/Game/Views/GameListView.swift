//
//  GameListView.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 10/3/23.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject var game: Game
    
    init(_ g: Game) { self.game = g }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(game.title).bold()
            HStack {
                DateView(game.release, false)
                Spacer()
                if !game.status { DateView(game.add, true) }
            }
        }
    }
    
    @ViewBuilder
    private func DateView(_ dt: Date, _ isAdd: Bool) -> some View {
        let color: Color = isAdd ? .gray : .black
        let iconName: String = "calendar\(isAdd ? ".badge.plus" : .empty)"
        let size: (CGFloat, CGFloat) = isAdd ? (18, 16) : (20, 20)
        let a = IconView(iconName, size.0, size.1)
        let b = Text(dt.dashes).italicize(isAdd, color)
        HStack(spacing: 8) {
            switch isAdd {
            case false : a;b
            case true: b;a
            }
        }
    }
    
}

