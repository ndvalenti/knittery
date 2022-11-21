//
//  PatternResultsView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternResultsView: View {
    @ObservedObject var patternResultsViewModel = PatternResultsViewModel()
    @Binding var path: [SearchViewModel.NavDestination]
    
    init(_ query: String?, path: Binding<[SearchViewModel.NavDestination]>) {
        self._path = path
        patternResultsViewModel.performSearch(query: query)
    }
    
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    ForEach (patternResultsViewModel.patternResults, id: \.id) { result in
                        NavigationLink(destination: PatternDetailsView(pattern: Pattern.mockData)) {
                            SinglePatternResultView(pattern: result)
                        }
                    }
                }
                .toolbarBackground(Color.KnitteryColor.backgroundDark, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("Pattern Search")
            }
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    @State static var path: [SearchViewModel.NavDestination] = []
    
    static var previews: some View {
        PatternResultsView(nil, path: $path)
    }
}
