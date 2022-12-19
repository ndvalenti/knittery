//
//  PatternResultsView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternResultsView: View {
    @StateObject var patternResultsViewModel = PatternResultsViewModel()
    @EnvironmentObject var sessionData: SessionData
    let searchTitle: String?
    let query: String?
    
    init(_ query: String?, searchTitle: String? = nil) {
        self.query = query
        self.searchTitle = searchTitle
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.KnitteryColor.darkBlue)]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            if let searchTitle {
                Text(searchTitle)
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top)
            }
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    if let patternResults = patternResultsViewModel.patternResults {
                        if patternResults.isEmpty {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(height: 75)
                                    .foregroundColor(Color.KnitteryColor.backgroundDark)
                                Text("No results matched your search and filters")
                                    .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                    .padding()
                            }
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.KnitteryColor.darkBlueTranslucent, lineWidth: 1))
                            .padding()
                        } else {
                            ForEach (patternResults, id: \.id) { result in
                                NavigationLink(destination: PatternDetailsView(result.id).environmentObject(sessionData)) {
                                    KnitteryPatternRow(pattern: result)
                                }
                            }
                        }
                    } else {
                        ForEach(0..<6) { placeholder in
                            KnitteryPatternRow(pattern: PatternResult.emptyData)
                        }
                    }
                }
                .navigationTitle("Pattern Search")
                .toolbar(.visible, for: .navigationBar)
                .toolbar {
                    NavigationToolbar(sessionData: sessionData)
                }
            }
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
        .onAppear() {
            patternResultsViewModel.checkPopulatePatterns(query)
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternResultsView(nil, searchTitle: "Search")
            .environmentObject(SessionData())
    }
}
