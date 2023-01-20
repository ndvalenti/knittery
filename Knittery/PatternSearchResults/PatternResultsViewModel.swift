//
//  PatternResultsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-21.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Combine
import Foundation

class PatternResultsViewModel: ObservableObject {
    @Published var patternResults: [PatternResult]?
    private var cancellables = Set<AnyCancellable>()

    func checkPopulatePatterns(_ query: String?) {
        if patternResults == nil, let query {
            performSearch(query: query)
        }
    }
    
    private func performSearch(query: String?) {
        if let query {
            NetworkHandler.requestPatternSearch(query: query)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching patterns search: \(error)")
                        self?.patternResults = []
                        self?.objectWillChange.send()
                    default: return
                    }
                }, receiveValue: { [weak self] search in
                    self?.patternResults = search.patterns
                    self?.objectWillChange.send()
                })
                .store(in: &cancellables)
        }
    }
}
