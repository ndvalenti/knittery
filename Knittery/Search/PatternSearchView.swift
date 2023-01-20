//
//  PatternSearchView.swift
//  Knittery
//
//  Created by Nick on 2022-10-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternSearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State var toggled: Bool = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Menu {
                Picker("Sort By", selection: $searchViewModel.query.sort) {
                    ForEach(QSort.allCases, id: \.self) { sortBy in
                        if let title = sortBy.displayName {
                            Text(title)
                                .tag(sortBy)
                        }
                    }
                }
            } label: {
                HStack {
                    Text("Sort By")
                        .foregroundColor(.black)
                    Spacer()
                    if let name = searchViewModel.query.sort.displayName {
                        Text(name)
                            .foregroundColor(.KnitteryColor.darkBlue)
                    }
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(.KnitteryColor.darkBlue)
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 20)
            }
            .background(.white)
            
            List(searchViewModel.searchCategories, children: \.items) { row in
                if let checked = row.isChecked {
                    KnitteryMultiPickerTab(title: row.categoryTitle, isChecked: checked) { isOn in
                        row.set(searchViewModel.query.updateSearchParameter(searchOptionCategory: row.category, key: row.categoryRaw, setValue: isOn))
                    }
                    .foregroundColor(Color.KnitteryColor.lightBlue)
                } else {
                    VStack (alignment: .leading) {
                        Text(row.categoryTitle)
                        Text(row.itemSubstring)
                            .foregroundColor(.KnitteryColor.darkBlueHalfTranslucent)
                            .font(.caption)
                            .lineLimit(1)
                            .padding(.leading, 5)
                    }
                    .padding(.top, 3)
                }
            }
            .listStyle(.plain)
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct PatternSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PatternSearchView(searchViewModel: SearchViewModel())
    }
}
