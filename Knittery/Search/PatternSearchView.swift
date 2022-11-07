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
                Section {
                    NavigationLink(destination: SearchOptionView(searchViewModel)) {
                        Text("Test")
                    }
                    
                } header: {
                    Text("Advanced Search Options")
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
