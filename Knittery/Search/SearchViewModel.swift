//
//  SearchViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation


class SearchViewModel: ObservableObject {
    var query: Query
//    {
//        didSet {
//            query.notebook = notebook.map { $0. }
//        }
//    }
    
    
//    @Published var times: [Date] {
//        didSet {
//            stringTimes = times.map { dateFormatter.string(from: $0) }
//        }
//    }
    init() {
        query = .init()
        // TODO: look at this again, looks horrible, not sure I can even map with dict values, might need to rethink structure again
//        notebook = .init()
//        QNotebook.allCases.forEach { [weak self] option in
//            self?.notebook[option] = (self?.query.notebook.contains(option) ?? false ? true : false)
//        }
    }
}
