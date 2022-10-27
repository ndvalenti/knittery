//
//  KnitteryTitles.swift
//  Knittery
//
//  Created by Nick on 2022-10-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct TitleBar: View {
    static private var fontSize: CGFloat = 40
    static private var paddingOffset: CGFloat { -(fontSize * 0.23) }
    
    let heading: String
    
    init(_ heading: String) {
        self.heading = heading
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.KnitteryColor.backgroundDark)
                .frame(height: 55)
            Text(heading)
                .foregroundColor(.KnitteryColor.lightBlue)
                .font(.custom("Avenir", size: TitleBar.fontSize, relativeTo: .largeTitle).weight(.medium))
                .padding(.vertical, TitleBar.paddingOffset)
                .shadow(color: .KnitteryColor.darkBlueTranslucent, radius: 6, x: 0, y: 3)
        }
    }
}

struct KnitteryTitles_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar("Sample")
    }
}
