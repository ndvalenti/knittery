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
    @Published private var queryString: String
    
    @Published var searchResults = [PatternResult]()
    
    enum NavDestination: Hashable {
        case result
    }
    
    init() {
        query = .init()
        queryString = .init()
    }
    
    func buildQuery() {
        queryString = QueryBuilder.build(query)
    }
}
