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
    
    var checkListItems: [CheckListItem]
    
    init(_ searchViewModel: SearchViewModel) {
        checkListItems = .init()
        checkListItems.append(CheckListItem(title: "Test", isChecked: true))
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        List (checkListItems) {
            MultiPickerTab(checkListItem: $0)
            // simulate a button, on click call function to update in searchviewmodel
            // svm should update all the relevant views and supply info for this view
        }
    }
}

struct SearchOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchOptionView(SearchViewModel())
    }
}
