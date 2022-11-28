//
//  KnitteryPatternPreviewBlock.swift
//  Knittery
//
//  Created by Nick on 2022-11-28.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryPatternPreviewBlock: View {
    var body: some View {
        VStack (spacing: 0){
            HStack {
                Text("Newly Added")
                    .fontWeight(.bold)
                    .font(.custom("Avenir", size: 22))
                    .foregroundColor(Color.KnitteryColor.darkBlue)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    NavigationLink (destination: PatternDetailsView(PatternResult.mockData.id)){
                        KnitteryPatternPreview(pattern: PatternResult.mockData)
                    }
                    NavigationLink (destination: PatternDetailsView(PatternResult.mockData.id)){
                        KnitteryPatternPreview(pattern: PatternResult.mockData)
                    }
                    NavigationLink (destination: PatternDetailsView(PatternResult.mockData.id)){
                        KnitteryPatternPreview(pattern: PatternResult.mockData)
                    }
                    NavigationLink (destination: PatternDetailsView(PatternResult.mockData.id)){
                        KnitteryPatternPreview(pattern: PatternResult.mockData)
                    }
                }
                .padding(.bottom)
                .padding([.top, .leading, .trailing], 5)
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct KnitteryDisplayBlock_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryPatternPreviewBlock()
    }
}
