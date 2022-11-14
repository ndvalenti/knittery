//
//  PatternDetailsView.swift
//  Knittery
//
//  Created by Nick on 2022-11-14.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternDetailsView: View {
    // TODO: display main image and a list? if we cache we can cache little images and fetch the larger ones when needed
    @State var pattern: Pattern
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleBar("Pattern")
            VStack(alignment: .leading) {
                if let name = pattern.name {
                    Text(name)
                        .font(.custom("SF Pro", size: 22, relativeTo: .largeTitle))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                }
                if let author = pattern.author {
                    Text("By \(author.name!)")
                        .font(.custom("SF Pro", size: 18, relativeTo: .largeTitle))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Divider()
            
            ScrollView (.horizontal) {
                HStack {
                    ForEach(pattern.photos, id: \.self.id) { photo in
                        AsyncImage(url: photo.squareURL, content: { image in
                            image
                                .resizable()
                                .frame(width: 150, height: 150)
                        }, placeholder: {
                            Rectangle().frame(width: 150, height: 150)
                                .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                        })
                        .onTapGesture {
                            // open photo.mediumURL modally
                        }
                    }
                }
                .frame(height: 150)
                Divider()
                
            }
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsView(pattern: Pattern.mockData)
    }
}
