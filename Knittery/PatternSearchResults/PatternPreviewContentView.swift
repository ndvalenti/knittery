//
//  PatternPreviewBlock.swift
//  Knittery
//
//  Created by Nick on 2022-11-28.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

// TODO: this is a mess that needs to be standardized to take a DefaultContent case and spit out the proper view with no external fuss
struct PatternPreviewContentView: View {
    @EnvironmentObject var sessionData: SessionData
    @Binding var results: [PatternResult]?
    let title: String?
    let fullQuery: Query?
    
    init(_ title: String?, results: Binding<[PatternResult]?>, fullQuery: Query? = nil) {
        self.title = title
        self._results = results
        fullQuery?.pageSize = nil
        self.fullQuery = fullQuery
    }
    
    var body: some View {
        if let title {
            if let results, !results.isEmpty, let fullQuery {
                VStack (spacing: 0) {
                    NavigationLink(destination: PatternResultsView(QueryBuilder.build(fullQuery))
                    ) {
                        HStack {
                            Text(title)
                                .fontWeight(.bold)
                                .font(.custom("Avenir", size: 22))
                                .lineLimit(1)
                                .foregroundColor(Color.KnitteryColor.darkBlue)
                            Spacer()
                            Text("More")
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding([.horizontal, .top], 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach (results, id: \.id) { result in
                                NavigationLink(destination: PatternDetailsView(result.id).environmentObject(sessionData)) {
                                    KnitteryPatternPreview(pattern: result)
                                }
                            }
                        }
                        .padding([.top, .trailing], 5)
                        .padding(.leading)
                    }
                    
                }
                .background(Color.KnitteryColor.backgroundLight)
            } else if results == nil {
                VStack (spacing: 0) {
                    HStack {
                        Text(title)
                            .fontWeight(.bold)
                            .font(.custom("Avenir", size: 22))
                            .foregroundColor(Color.KnitteryColor.darkBlue)
                        Spacer()
                    }
                    .padding([.horizontal, .top], 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach (0..<4) { placeholder in
                                KnitteryPatternPreview(pattern: PatternResult.emptyData)
                            }
                        }
                        .padding([.top, .trailing], 5)
                        .padding(.leading)
                    }
                }
                .background(Color.KnitteryColor.backgroundLight)
            }
        }
    }
}

struct KnitteryDisplayBlock_Previews: PreviewProvider {
    @State static private var results:  [PatternResult]? = []
    static var previews: some View {
        PatternPreviewContentView("Test", results: $results)
            .environmentObject(SessionData())
    }
}
