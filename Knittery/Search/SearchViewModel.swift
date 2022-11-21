//
//  SearchViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var query: Query
    @Published private var queryURL: String
    
    @Published var searchResults = [PatternResult]()
    
    enum NavDestination: Hashable {
        case result , details
    }
    
    init() {
        query = .init()
        queryURL = .init()
    }
    
    func buildQuery() {
        queryURL = QueryBuilder.build(query)
    }
//    func getSearchResults() {
//        NetworkHandler.requestPatternSearch() { [weak self] (result: Result<PatternSearch, ApiError>) in
//            switch result {
//            case .success (let search):
//                self?.searchResults = search.patterns
//            case .failure (let error):
//                print(error)
//            }
//        }
//    }
}
