//
//  SinglePatternResultView.swift
//  Knittery
//
//  Created by Nick on 2022-11-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct SinglePatternResultView: View {
    var pattern: PatternResult
    
    var body: some View {
        Group {
            HStack {
                if let firstImage = pattern.firstPhoto {
                    AsyncImage(url: firstImage.smallURL, content: { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                    }, placeholder: {
                        Rectangle().frame(width: 150, height: 150)
                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                    })
                } else {
                    Image(systemName: "snowflake")
                }
                
                VStack (alignment: .leading){
                    Text("Name and stuff")
                        .padding(.horizontal)
                    Text("Author")
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer()
            }
            .frame(height:150)
            .background(Color.KnitteryColor.backgroundDark)
            .cornerRadius(16)
        }
        .frame(height: 175)
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct SingleResultView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePatternResultView(pattern: PatternResult.mockData)
    }
}
