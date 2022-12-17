//
//  CategorySearchView.swift
//  Knittery
//
//  Created by Nick on 2022-12-14.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CategorySearchView: View {
    @StateObject var categorySearchViewModel = CategorySearchViewModel()
    @EnvironmentObject var sessionData: SessionData
    
    var body: some View {
        VStack {
            TextField("Filter", text: $categorySearchViewModel.filter)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(6)
                .padding(.leading, 8)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.KnitteryColor.darkBlueTranslucent, lineWidth: 1))
                .padding()

            if categorySearchViewModel.filter == "" {
                if let categories = sessionData.categories?.children {
                    CategorySearchTreeView(categorySearchViewModel: categorySearchViewModel, categories: categories)
                }
            } else {
                if let flatChildren = sessionData.categories?.flatChildren {
                    CategorySearchListView(categorySearchViewModel: categorySearchViewModel, flatChildren: flatChildren)
                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct CategorySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySearchView()
            .environmentObject(SessionData())
    }
}
