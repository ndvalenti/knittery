//
//  SearchResultsView.swift
//  Knittery
//
//  Created by Nick on 2022-10-31.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack {
            ZStack {
                TextField("Search", text: $searchViewModel.query.search)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .border(Color.KnitteryColor.darkBlueTranslucent)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        // TODO: re-run search?
                    }
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                        .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Results")
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(searchViewModel: SearchViewModel())
    }
}
