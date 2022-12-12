//
//  KnitteryPatternRow.swift
//  Knittery
//
//  Created by Nick on 2022-11-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryPatternRow: View {
    var pattern: PatternResult
    
    var body: some View {
        Group {
            VStack (alignment: .leading) {
                Group {
                    Text(pattern.name ?? .placeholder(length: Int.random(in: 5...20)))
                        .fontWeight(.medium)
                        .font(.custom("Avenir", size: 18, relativeTo: .headline))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                        .lineLimit(1)
                    
                    Text(pattern.author?.name ?? .placeholder(length: Int.random(in: 10...25)))
                        .font(.custom("SF Pro", size: 14, relativeTo: .caption))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                        .lineLimit(1)
                }
                .padding(.leading)
                if let firstImage = pattern.firstPhoto {
                    AsyncImage(url: firstImage.smallURL, content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipShape(Rectangle())
                    }, placeholder: {
                        Rectangle().frame(height: 150)
                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                    })
                } else {
                    Rectangle().frame(height: 150)
                        .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                }
            }
            .frame(height:225)
            .background(Color.KnitteryColor.backgroundLight)
            .redacted(reason: pattern.id == nil ? .placeholder : [])
        }
    }
}

struct SingleResultView_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryPatternRow(pattern: PatternResult.mockData)
    }
}
