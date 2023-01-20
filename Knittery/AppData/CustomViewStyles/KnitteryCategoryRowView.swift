//
//  KnitteryCategoryRowView.swift
//  Knittery
//
//  Created by Nick on 2022-12-15.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryCategoryRowView: View {
    @State var category: PatternCategory
    
    var body: some View {
        if let rowname = category.longname {
            let searchTitle = "Displaying results for \(rowname)"
            if category.children == nil {
                NavigationLink(destination: PatternResultsView(QueryBuilder.build(Query(patternCategory: category)), searchTitle: searchTitle)) {
//                NavigationLink(destination: { Text("Navlink!") }) {
                    if category.ghostCategory {
                        let modRowname = "All " + rowname
                        Text(modRowname)
                            .foregroundColor(.KnitteryColor.lightBlue)
                    } else {
                        Text(rowname)
                            .foregroundColor(.KnitteryColor.lightBlue)
                    }
                }
            } else {
                Label(rowname, systemImage: "folder.fill")
                    .foregroundColor(.KnitteryColor.darkBlue)
            }
        }
    }
}

struct KnitteryCategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryCategoryRowView(category: PatternCategory())
    }
}
