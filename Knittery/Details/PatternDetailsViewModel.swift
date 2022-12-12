//
//  PatternDetailsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-22.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class PatternDetailsViewModel: ObservableObject {
    @Published var pattern = Pattern.emptyData
    @Published var isFavorited: Bool = false
    @Published var bookmarkId: Int?
    
    func retrievePattern(patternId: Int?) {
        if let patternId  {
            NetworkHandler.requestPatternById(patternId) { [weak self] (result: Result<Pattern, ApiError>) in
                switch result {
                case .success (let pattern):
                    DispatchQueue.main.async {
                        self?.pattern = pattern
                        self?.isFavorited = pattern.personalAttributes?.favorited ?? false
                        self?.bookmarkId = pattern.personalAttributes?.bookmarkId
                    }
                case .failure (let error):
                    print(error)
                }
            }
        }
    }
    
    func toggleFavorite(username: String?) {
        guard let username else { return }
        switch isFavorited {
        case true:
            guard let bookmarkId else { return }
            
            NetworkHandler.deleteFavorite(bookmarkId: String(bookmarkId), username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
                switch result {
                case .success:
                    DispatchQueue.main.sync {
                        self?.bookmarkId = nil
                        self?.isFavorited = false
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
        case false:
            guard let patternId = pattern.id else { return }
            
            NetworkHandler.addFavorite(patternId: String(patternId), username: username) { [weak self] (result: Result<Bookmark, ApiError>) in
                switch result {
                case .success(let bookmark):
                    DispatchQueue.main.sync {
                        self?.bookmarkId = bookmark.id
                        self?.isFavorited = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
