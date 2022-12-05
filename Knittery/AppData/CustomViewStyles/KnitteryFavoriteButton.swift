//
//  KnitteryFavoriteButton.swift
//  Knittery
//
//  Created by Nick on 2022-12-05.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryFavoriteButton: View {
    @State var isSelected: Bool
    @State var action: (Bool) -> Void
    @State var actionSize: Double = 44
    @State var imageSize: Double = 32
    @State var inactiveColor: Color = Color.KnitteryColor.backgroundLight
    @State var activeColor: Color = Color.KnitteryColor.red
    @State var borderColor: Color = Color.KnitteryColor.darkBlueTranslucent
    
    var body: some View {
        Button {
            isSelected.toggle()
            action(isSelected)
        } label: {
            Image(systemName: ("heart.fill"))
                .resizable()
                .scaledToFit()
                .frame(width: imageSize)
                .foregroundColor(isSelected ? activeColor : inactiveColor)
                .overlay {
                    Image(systemName: ("heart"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize)
                        .foregroundColor(borderColor)
                }
            
        }
        .frame(width: actionSize, height: actionSize)
    }
    
    func toggle() { isSelected.toggle() }
}

struct KnitteryFavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryFavoriteButton(isSelected: false) { _ in
            
        }
    }
}
