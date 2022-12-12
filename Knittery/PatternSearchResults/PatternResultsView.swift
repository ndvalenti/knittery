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
    @Binding var path: [SearchViewModel.NavDestination]
    @EnvironmentObject var sessionData: SessionData
    let search: String
    let query: String?
    
    init(_ query: String?, path: Binding<[SearchViewModel.NavDestination]>, search: String) {
        self._path = path
        self.query = query
        self.search = search
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.KnitteryColor.darkBlue)]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            Text("Displaying results for \"\(search)\"")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top)
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
    @State static var path: [SearchViewModel.NavDestination] = []
    
    static var previews: some View {
        PatternResultsView(nil, path: $path, search: "Search")
            .environmentObject(SessionData())
    }
}
