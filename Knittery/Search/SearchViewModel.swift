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
    
    init() {
        query = .init()
    }
}
