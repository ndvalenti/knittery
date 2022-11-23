//
//  PatternDetailsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-22.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class PatternDetailsViewModel: ObservableObject {
    // TODO: pattern being nil should trigger some loading view and not just empty
    @Published var pattern = Pattern.emptyData
    
    func retrievePattern(patternId: Int?) {
        if let patternId  {
            NetworkHandler.requestPatternById(patternId) { [weak self] (result: Result<Pattern, ApiError>) in
                switch result {
                case .success (let pattern):
                    DispatchQueue.main.async {
                        self?.pattern = pattern
                    }
                case .failure (let error):
                    print(error)
                }
            }
        } else {
            //TODO: handle nil id?
        }
    }
}
