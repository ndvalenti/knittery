//
//  KnitteryPatternPreview.swift
//  Knittery
//
//  Created by Nick on 2022-11-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryPatternPreview: View {
    var pattern: PatternResult
    private let previewSize: CGFloat = 275.0
    private let leadPadding: CGFloat = 7.0
    private let topPadding: CGFloat = 5.0
    private let lineWidth: CGFloat = 1.0
    private let cornerRadius: CGFloat = 8.0
    
    var body: some View {
        Group {
            ZStack (alignment: .leading) {
                if let firstImage = pattern.firstPhoto {
                    AsyncImage(url: firstImage.smallURL, content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: previewSize, height: previewSize)
                            .clipShape(Rectangle())
                    }, placeholder: {
                        Rectangle().frame(width: previewSize, height: previewSize)
                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                    })
                } else {
                    Rectangle().frame(width: previewSize, height: previewSize)
                        .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                        .clipShape(Rectangle())
                }
                VStack (alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(pattern.name ?? .placeholder(length: Int.random(in: 5...20)))
                                .fontWeight(.medium)
                                .font(.title3)
                                .foregroundColor(Color.KnitteryColor.backgroundDark)
                                .lineLimit(1)
                            Text(pattern.author?.name ?? .placeholder(length: Int.random(in:8...23)))
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
            .padding(.horizontal)
            .frame(width: previewSize, height: previewSize)
            .background(Color.KnitteryColor.backgroundDark)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.KnitteryColor.lightBlue, lineWidth: lineWidth))
            .redacted(reason: pattern.firstPhoto == nil ? .placeholder : [])
        }
    }
}

struct KnitteryPatternBlock_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryPatternPreview(pattern: PatternResult.mockData)
    }
}
