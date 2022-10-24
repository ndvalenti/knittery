//
//  KnitteryButtons.swift
//  Knittery
//
//  Created by Nick on 2022-10-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct StandardButton: ButtonStyle {
    var width: CGFloat? = .infinity
    var height: CGFloat? = .infinity
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: width, height: height)
            .foregroundColor(.white)
            .background(Color.KnitteryColor.lightBlue)
            .cornerRadius(48)
            .font(.custom("Avenir", size: 20, relativeTo: .largeTitle))
    }
}
