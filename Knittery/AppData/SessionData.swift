//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Combine
import Foundation
import UIKit

class SessionData: ObservableObject {
    @Published var defaultQueries = [DefaultQuery: [PatternResult]]()
    private var cancellables = Set<AnyCancellable>()
    weak var signOutDelegate: SignOutDelegate?
    
    @Published var currentUser: User? { didSet {
        guard let currentUser, let photoURL = currentUser.photoURL else {
            profilePicture = nil
            return
        }
        
        NetworkHandler.loadImageFrom(url: photoURL) { image in
            self.profilePicture = image
        }
    } }
    
    @Published var profilePicture: UIImage? = nil
    
    func populateQueries() {
        DefaultQuery.allCases.forEach { defaultQuery in
            populateDefaultQuery(defaultQuery)
        }
    }
    
    func populateDefaultQuery(_ defaultQuery: DefaultQuery) {
        if currentUser != nil {
            NetworkHandler.requestPatternSearch(query: defaultQuery.query)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print("Error fetching default queries: \(error)")
                        self?.defaultQueries[defaultQuery] = nil

                    default: return
                    }
                }, receiveValue: { [weak self] search in
                    self?.defaultQueries[defaultQuery] = search.patterns
                })
                .store(in: &cancellables)
        }
    }
    
    func invalidateDefaultQuery(_ query: DefaultQuery) {
        defaultQueries[query] = nil
    }
    
    private func invalidateAllDefaultQueries() {
        DefaultQuery.allCases.forEach { query in
            invalidateDefaultQuery(query)
        }
    }
    
    func signOut() {
        signOutDelegate?.signOut()
    }
    
    func clearData() {
        currentUser = nil
        invalidateAllDefaultQueries()
    }
}


