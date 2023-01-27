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
    private let previewHeight: CGFloat = 250.0
    private let leadPadding: CGFloat = 7.0
    private let topPadding: CGFloat = 5.0
    private let bottomPadding: CGFloat = 50.0
    private let lineWidth: CGFloat = 1.0
    
    var body: some View {
        Group {
            ZStack (alignment: .leading) {
                if let firstImage = pattern.firstPhoto {
                    AsyncImage(url: firstImage.smallURL, content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: previewHeight)
                            .clipShape(Rectangle())
                    }, placeholder: {
                        Rectangle().frame(height: previewHeight)
                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                    })
                } else {
                    Rectangle().frame(height: previewHeight)
                        .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                }
                
                VStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text(pattern.name ?? .placeholder(length: Int.random(in: 5...20)))
                                .fontWeight(.medium)
                                .font(.title2)
                                .foregroundColor(Color.KnitteryColor.backgroundDark)
                                .lineLimit(1)
                            
                            Text(pattern.author?.name ?? .placeholder(length: Int.random(in: 10...25)))
                                .font(.subheadline)
                                .foregroundColor(Color.KnitteryColor.backgroundDark)
                                .lineLimit(1)
                        }
                        .padding(.vertical, topPadding)
                        .padding(.leading, leadPadding)
                        Spacer()
                    }
                    .background(Color.KnitteryColor.darkBlueHalfTranslucent)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: previewHeight)
            .overlay(Rectangle()
                .stroke(Color.KnitteryColor.lightBlue, lineWidth: lineWidth))
            .redacted(reason: pattern.firstPhoto == nil ? .placeholder : [])
        }
        .padding(.bottom, bottomPadding)
    }
}

struct SingleResultView_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryPatternRow(pattern: PatternResult.mockData)
    }
}
