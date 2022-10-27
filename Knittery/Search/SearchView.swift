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

    @State private var selectedMode: SearchModes
    @State var searchText: String
    
    init() {
        searchText = .init()
        selectedMode = .pattern
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.KnitteryColor.lightBlue)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.KnitteryColor.backgroundLight)], for: .selected)
    }
    
    var body: some View {
        
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
                    TextField("Search", text: $searchText)
                        .border(Color.KnitteryColor.darkBlueTranslucent)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.KnitteryColor.lightBlue)
                            .padding()
                    }.padding(.horizontal)
                }
                switch(selectedMode) {
                case .pattern:
                    PatternSearchView()
                case .yarn:
                    YarnSearchView()
                }
                
                Spacer()
            }
            .background(Color.KnitteryColor.backgroundDark)
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
