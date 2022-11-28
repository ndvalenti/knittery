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
                    if let name = pattern.name {
                        Text(name)
                            .fontWeight(.medium)
                            .font(.custom("Avenir", size: 18, relativeTo: .headline))
                            .foregroundColor(Color.KnitteryColor.darkBlue)
                            .lineLimit(1)
                    }
                    if let author = pattern.author {
                        if let authorName = author.name {
                            
                            Text("by \(authorName)")
                                .font(.custom("SF Pro", size: 14, relativeTo: .caption))
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                                .lineLimit(1)
                        }
                    }
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
        }
    }
}

struct SingleResultView_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryPatternRow(pattern: PatternResult.mockData)
    }
}
