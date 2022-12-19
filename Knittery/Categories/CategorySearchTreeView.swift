//
//  CategorySearchTreeView.swift
//  Knittery
//
//  Created by Nick on 2022-12-15.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CategorySearchTreeView: View {
    @ObservedObject var categorySearchViewModel: CategorySearchViewModel
    @State var categories: [PatternCategory]?
    
    var body: some View {
        Group {
            if let categories {
                List(categories, id: \.uuid, children: \.children) { row in
                    KnitteryCategoryRowView(category: row)
                }
            } else {
                List {
                    Text("No category information found")
                        .foregroundColor(.KnitteryColor.darkBlue)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct CategorySearchTreeView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearchTreeView(categorySearchViewModel: CategorySearchViewModel(), categories: [])
    }
}
