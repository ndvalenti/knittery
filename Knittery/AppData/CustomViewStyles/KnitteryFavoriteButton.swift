//
//  KnitteryFavoriteButton.swift
//  Knittery
//
//  Created by Nick on 2022-12-05.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryFavoriteButton: View {
    @Binding var isSelected: Bool
    @State var action: () -> Void
    let actionSize: Double = 44
    let imageSize: Double = 32
    let inactiveColor: Color = Color.KnitteryColor.backgroundLight
    let activeColor: Color = Color.KnitteryColor.red
    let borderColor: Color = Color.KnitteryColor.darkBlueTranslucent
    
    var body: some View {
        Button {
//            isSelected.toggle()
            action()
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
    @State static var isFavorited = false
    static var previews: some View {
        KnitteryFavoriteButton(isSelected: $isFavorited) { 
            
        }
    }
}
