//
//  PatternResultsView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternResultsView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var path: [SearchViewModel.NavDestination]
    
    var insets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
    
    var body: some View {
        VStack {
            List {
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                SinglePatternResultView(pattern: PatternResult.mockData)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
        }
        .toolbarBackground(Color.KnitteryColor.backgroundDark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("Displaying results for \(searchViewModel.query.search)")
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    @State static var path: [SearchViewModel.NavDestination] = []
    static var previews: some View {
        PatternResultsView(searchViewModel: SearchViewModel(), path: $path)
    }
}
