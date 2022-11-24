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
                    Text(pattern.name!)
                        .font(.headline)
                    Text("by \(pattern.author!.name!)")
                        .font(.caption)
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
//                    Image(systemName: "snowflake")
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
