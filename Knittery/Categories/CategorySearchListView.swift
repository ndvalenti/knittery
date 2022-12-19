//
//  CategorySearchListView.swift
//  Knittery
//
//  Created by Nick on 2022-12-15.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CategorySearchListView: View {
    @ObservedObject var categorySearchViewModel: CategorySearchViewModel
    @State var flatChildren: [PatternCategory]?
    
    var searchResults: [PatternCategory]? {
        if categorySearchViewModel.filter.isEmpty {
            return flatChildren
        } else {
            return flatChildren?.filter { $0.longname?.lowercased().contains(categorySearchViewModel.filter.lowercased()) == true }
        }
    }
    
    var body: some View {
        Group {
            if let searchResults, !searchResults.isEmpty {
                List(searchResults, id: \.uuid) { row in
                    KnitteryCategoryRowView(category: row)
                }
            } else {
                List {
                    Text("No results")
                        .foregroundColor(.KnitteryColor.darkBlue)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct CategorySearchListView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearchListView(categorySearchViewModel: CategorySearchViewModel(), flatChildren: [])
    }
}
