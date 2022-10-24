//
//  KnitteryTitles.swift
//  Knittery
//
//  Created by Nick on 2022-10-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct TitleBar: View {
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
                .font(.custom("Avenir", size: 40, relativeTo: .largeTitle))
                .shadow(color: .KnitteryColor.darkBlue, radius: 5, x: 0, y: 3)
        }
    }
}

struct KnitteryTitles_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar("Sample")
    }
}
