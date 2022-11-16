//
//  LibraryViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-09-28.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class LibraryViewModel: ObservableObject {
    var pattern: Pattern?
    var user: User?
    var patterns: [PatternResult]?
    
    func testAPICall() {
        NetworkHandler.requestPatternById("688190") { [weak self] (result: Result<Pattern, ApiError>) in
                switch result {
                case .success(let pattern):
                    self?.pattern = pattern
                    print(pattern)
                case .failure(let error):
                    print(error)
                }
        }
        
//        NetworkHandler.requestPatternById("1287310") { [weak self] (result: Result<Pattern, ApiError>) in
//                switch result {
//                case .success(let pattern):
//                    self?.pattern = pattern
//                    print(pattern)
//                case .failure(let error):
//                    print(error)
//                }
//        }
        
//        NetworkHandler.requestPatternSearch() { [weak self] (result: Result<PatternSearch, ApiError>) in
//            switch result {
//            case .success (let search):
//                self?.patterns = search.patterns
//                print(search.patterns)
//            case .failure (let error):
//                print(error)
//            }
//        }
//
//        NetworkHandler.requestCurrentUser() { [weak self] (result: Result<User, ApiError>) in
//            switch result {
//            case .success(let user):
//                self?.user = user
//                print(user)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
