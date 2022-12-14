//
//  PatternPreviewBlock.swift
//  Knittery
//
//  Created by Nick on 2022-11-28.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternPreviewContentView: View {
    @EnvironmentObject var sessionData: SessionData
    @Binding var results: [PatternResult]?
    let title: String
    
    init(_ title: String, results: Binding<[PatternResult]?>) {
        self.title = title
        self._results = results
    }
    
    var body: some View {
        VStack (spacing: 0) {
            if let results, !results.isEmpty {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.custom("Avenir", size: 22))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach (results, id: \.id) { result in
                            NavigationLink(destination: PatternDetailsView(result.id).environmentObject(sessionData)) {
                                KnitteryPatternPreview(pattern: result)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding([.top, .leading, .trailing], 5)
                }
            } else if results == nil {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.custom("Avenir", size: 22))
                        .foregroundColor(Color.KnitteryColor.darkBlue)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach (0..<4) { placeholder in
                            KnitteryPatternPreview(pattern: PatternResult.emptyData)
                        }
                    }
                    .padding(.bottom)
                    .padding([.top, .leading, .trailing], 5)
                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct KnitteryDisplayBlock_Previews: PreviewProvider {
    @State static private var results:  [PatternResult]? = []
    static var previews: some View {
        PatternPreviewContentView("Test", results: $results)
            .environmentObject(SessionData())
    }
}
