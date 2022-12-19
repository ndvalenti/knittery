//
//  SearchView.swift
//  Knittery
//
//  Created by Nick on 2022-10-25.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

enum SearchModes: String, CaseIterable, Identifiable {
    case advanced = "Advanced Search"
    case categories = "Categories"
    var id: Self { self }
}

struct SearchView: View {
    @State private var path: [SearchViewModel.NavDestination] = []
    @State var selectedMode: SearchModes
    @StateObject var searchViewModel = SearchViewModel()
    @EnvironmentObject var sessionData: SessionData
    let navigationTitle: String
    
    init(_ navigationTitle: String = "Search", selectedMode: SearchModes = .advanced) {
        self.selectedMode = selectedMode
        self.navigationTitle = navigationTitle
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.KnitteryColor.lightBlue)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.KnitteryColor.backgroundLight)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.KnitteryColor.darkBlue)], for: .normal)
    }
    
    var body: some View {
        NavigationStack (path: $path) {
            VStack {
                Picker("Title", selection: $selectedMode) {
                    ForEach(SearchModes.allCases) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .blendMode(.normal)
                .padding(.top)
                
                VStack {
                    switch(selectedMode) {
                    case .advanced:
                        ZStack {
                            TextField("Search", text: $searchViewModel.query.search)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .padding(6)
                                .padding(.leading, 8)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.KnitteryColor.darkBlueTranslucent, lineWidth: 1))
                                .padding()
                                .onSubmit {
                                    path.append(.result)
                                }
                                .navigationDestination(for: SearchViewModel.NavDestination.self) {
                                    switch $0 {
                                    case .result:
                                        PatternResultsView(QueryBuilder.build(searchViewModel.query), searchTitle: searchViewModel.query.searchTitle)
                                            .environmentObject(sessionData)
                                    }
                                }
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                                    .padding()
                            }
                            .padding(.horizontal)
                        }
                        PatternSearchView(searchViewModel: searchViewModel)
                    case .categories:
                        CategorySearchView()
                    }
                }
                
            }
            .background(Color.KnitteryColor.backgroundDark)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .navigationBar)
            .toolbar {
                NavigationToolbar(title: navigationTitle, sessionData: sessionData)
            }
        }
        .environmentObject(sessionData)
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(selectedMode: .advanced)
            .environmentObject(SessionData())
    }
}
