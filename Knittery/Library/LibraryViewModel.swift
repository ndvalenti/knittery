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
    }
}
