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
    let title: String?
    let categorySearchLink: Bool
    let fullQuery: Query?
    
    init(_ title: String?, results: Binding<[PatternResult]?>, categorySearchLink: Bool = false, fullQuery: Query? = nil) {
        self.title = title
        self._results = results
        self.categorySearchLink = categorySearchLink
        fullQuery?.pageSize = nil
        self.fullQuery = fullQuery
    }
    
    var body: some View {
        VStack (spacing: 0) {
            if let title {
                if let results, !results.isEmpty, let fullQuery {
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
                    
//                    if categorySearchLink {
//                        NavigationLink(destination: SearchView("", selectedMode: .categories)) {
//                            HStack {
//                                Text("Browse All Categories")
//                                    .fontWeight(.medium)
//                                    .padding(.leading, 10)
//                                Spacer()
//                                Image(systemName: "chevron.right")
////                                    .padding(.trailing, 10)
//                            }
//                            .padding(.all, 10)
//                            .background(Color.KnitteryColor.backgroundDark)
//                            .foregroundColor(Color.KnitteryColor.darkBlue)
//                            .cornerRadius(8)
//                        }
//                        .padding()
//                    }
                    
                } else if results == nil {
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
