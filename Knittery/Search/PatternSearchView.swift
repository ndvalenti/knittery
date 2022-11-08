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
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: SearchOptionView(searchViewModel: searchViewModel, currentCategory: .notebook)) {
                    Text(QNotebook.categoryName)
                }
                NavigationLink(destination: SearchOptionView(searchViewModel: searchViewModel, currentCategory: .craft)) {
                    Text(QCraft.categoryName)
                }
                NavigationLink(destination: SearchOptionView(searchViewModel: searchViewModel, currentCategory: .availability)) {
                    Text(QAvailability.categoryName)
                }
                NavigationLink(destination: SearchOptionView(searchViewModel: searchViewModel, currentCategory: .weight)) {
                    Text(QWeight.categoryName)
                }
            }
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct PatternSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PatternSearchView(searchViewModel: SearchViewModel())
    }
}
