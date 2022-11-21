//
//  PatternResultsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-21.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class PatternResultsViewModel: ObservableObject {
    @Published var patternResults = [PatternResult]()
    
    func performSearch(query: String?) {
        guard let query else { return }
        NetworkHandler.requestPatternSearch(query: query) { [weak self] (result: Result<PatternSearch, ApiError>) in
            switch result {
            case .success (let search):
                DispatchQueue.main.async {
                    self?.patternResults = search.patterns
                }
            case .failure (let error):
                print(error)
            }
        }
    }
}
