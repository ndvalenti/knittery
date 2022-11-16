//
//  SearchOptionView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct SearchOptionView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    
    let currentCategory: SearchOptionCategory
    
    var body: some View {
        List {
            switch currentCategory {
            case .notebook:
                ForEach (QNotebook.allCases, id: \.self) { item in
                    if let name = item.displayName {
                        MultiPickerTab(
                            title: name,
                            isChecked: searchViewModel.query.notebook[item] ?? false) { isOn in
                                searchViewModel.query.notebook[item] = isOn
                            }
                    }
                }
            case .craft:
                ForEach (QWeight.allCases, id: \.self) { item in
                    if let name = item.displayName {
                        MultiPickerTab(
                            title: name,
                            isChecked: searchViewModel.query.weight[item] ?? false) { isOn in
                                searchViewModel.query.weight[item] = isOn
                            }
                    }
                }
            case .availability:
                ForEach (QAvailability.allCases, id: \.self) { item in
                    if let name = item.displayName {
                        MultiPickerTab(
                            title: name,
                            isChecked: searchViewModel.query.availability[item] ?? false) { isOn in
                                searchViewModel.query.availability[item] = isOn
                            }
                    }
                }
            case .weight:
                ForEach (QWeight.allCases, id: \.self) { item in
                    if let name = item.displayName {
                        MultiPickerTab(
                            title: name,
                            isChecked: searchViewModel.query.weight[item] ?? false) { isOn in
                                searchViewModel.query.weight[item] = isOn
                            }
                    }
                }
            default: EmptyView()
            }
        }
        .navigationTitle(currentCategory.display)
    }
}

struct SearchOptionView_Previews: PreviewProvider {
    @State static var testBook: [QNotebook : Bool] = [QNotebook.favorites : false]
    
    static var previews: some View {
        SearchOptionView(searchViewModel: SearchViewModel(), currentCategory: .notebook)
    }
}
