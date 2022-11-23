//
//  SearchView.swift
//  Knittery
//
//  Created by Nick on 2022-10-25.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    enum SearchModes: String, CaseIterable, Identifiable {
        case pattern = "Patterns"
        case yarn = "Yarns"
        var id: Self { self }
    }
    @State private var path: [SearchViewModel.NavDestination] = []
    @State private var selectedMode: SearchModes
    
    @StateObject var searchViewModel = SearchViewModel()
    
    init() {
        selectedMode = .pattern
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.KnitteryColor.lightBlue)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.KnitteryColor.backgroundLight)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.KnitteryColor.darkBlue)], for: .normal)
    }
    
    var body: some View {
        NavigationStack (path: $path) {
            VStack {
                TitleBar("Search")
                VStack {
                    Picker("Title", selection: $selectedMode) {
                        ForEach(SearchModes.allCases) { value in
                            Text(value.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .blendMode(.normal)
                    ZStack {
                        TextField("Search", text: $searchViewModel.query.search)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .border(Color.KnitteryColor.darkBlueTranslucent)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .onSubmit {
//                                searchViewModel.buildQuery()
//                                QueryBuilder.build(searchViewModel.query)
                                path.append(.result)
                            }
                            .navigationDestination(for: SearchViewModel.NavDestination.self) {
                                switch $0 {
                                case .result:
//                                    QueryBuilder.build(searchViewModel.query)
//                                    print(query)
                                    PatternResultsView(QueryBuilder.build(searchViewModel.query), path: $path)
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
                    
                    VStack {
//                        Text("List Selected Search Options Here")
                        switch(selectedMode) {
                        case .pattern:
                            PatternSearchView(searchViewModel: searchViewModel)
                        case .yarn:
                            YarnSearchView()
                        }
                    }
                    .background(Color.KnitteryColor.backgroundDark)
                }
                .background(Color.KnitteryColor.backgroundDark)
            }
            .background(Color.KnitteryColor.backgroundLight)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
