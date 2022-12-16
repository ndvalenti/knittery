//
//  PatternDetailsViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-22.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Combine
import Foundation

class PatternDetailsViewModel: ObservableObject {
    @Published var pattern = Pattern.emptyData
    @Published var isFavorited: Bool = false
    @Published var bookmarkId: Int?

    private var cancellables = Set<AnyCancellable>()
    
    func retrievePattern(patternId: Int?) {
        if let patternId  {
            NetworkHandler.requestPatternById(patternId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching patterns search: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] pattern in
                    self?.pattern = pattern
                    self?.isFavorited = pattern.personalAttributes?.favorited ?? false
                    self?.bookmarkId = pattern.personalAttributes?.bookmarkId
                })
                .store(in: &cancellables)
        }
    }
    
    func toggleFavorite(username: String?) {
        guard let username else { return }
        switch isFavorited {
        case true:
            guard let bookmarkId else { return }
            NetworkHandler.deleteFavorite(bookmarkId: String(bookmarkId), username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error deleting bookmark: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] bookmark in
                    self?.bookmarkId = nil
                    self?.isFavorited = false
                })
                .store(in: &cancellables)

        case false:
            guard let patternId = pattern.id else { return }
            NetworkHandler.addFavorite(patternId: String(patternId), username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Error creating bookmark: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] bookmark in
                    self?.bookmarkId = bookmark.id
                    self?.isFavorited = true
                })
                .store(in: &cancellables)
        }
    }
}
