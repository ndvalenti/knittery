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
//        let url = URL(string: "https://api.ravelry.com/patterns/search.json?query=speckled-super-scarf")
//        let url = URL(string: "https://api.ravelry.com/patterns/688190.json")
//        let url = URL(string: "https://api.ravelry.com/current_user.json")
        let request = NetworkHandler.buildPatternRequestById(688190)
        NetworkHandler.makeRequest(request!) { [weak self] (result: Result<PatternWrapper, ApiError>) in
            switch result {
            case .success(let DTO):
                self?.pattern = DTO.pattern
            case .failure(let error):
                print(error)
            }
        }
    }
}
