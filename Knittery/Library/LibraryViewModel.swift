//
//  LibraryViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-09-28.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class LibraryViewModel: ObservableObject {
//    var pattern: Pattern?
//    var user: User?
//    var patterns: [PatternResult]?
    
//    func testAPICall() {
//        NetworkHandler.requestCurrentUser() { [weak self] (result: Result<User, ApiError>) in
//            switch result {
//            case .success(let user):
//                self?.user = user
//                print(user)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func addFavorite(username: String) {
        NetworkHandler.addFavorite(patternId: "1293627", username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
            switch result {
            case .success(let bookmark):
                print(bookmark)
            case .failure(let error):
                print(error)
            }
        }
    }
    func deleteFavorite(username: String) {
        NetworkHandler.deleteFavorite(bookmarkId: "414783690", username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
            switch result {
            case .success(let bookmark):
                print(bookmark)
            case .failure(let error):
                print(error)
            }
        }
    }
}
